/**
 * Subagent Tool - Delegate context-heavy work to an isolated subagent
 *
 * Spawns a separate `pi` process (--mode json -p --no-session) with the same
 * user config, default tools, and default model. Only the subagent's final
 * output is returned to the parent, keeping intermediate tool spam out of the
 * main context window.
 *
 * There are no specialized agent profiles: the subagent is a plain pi instance.
 * The parent model decides when a task is worth delegating.
 *
 * Recursion guard: PI_SUBAGENT=1 is set in the child environment; when present,
 * this extension does not register the tool, so subagents can't spawn subagents.
 */

import { spawn } from "node:child_process";
import * as fs from "node:fs";
import * as os from "node:os";
import * as path from "node:path";
import type { AgentToolResult } from "@earendil-works/pi-agent-core";
import type { Message } from "@earendil-works/pi-ai";
import { type ExtensionAPI, getMarkdownTheme } from "@earendil-works/pi-coding-agent";
import { Container, Markdown, Spacer, Text } from "@earendil-works/pi-tui";
import { Type } from "typebox";

const OUTPUT_CAP = 40 * 1024; // Max bytes of final output returned to the parent
const COLLAPSED_ITEM_COUNT = 8;

interface UsageStats {
	input: number;
	output: number;
	cacheRead: number;
	cacheWrite: number;
	cost: number;
	contextTokens: number;
	turns: number;
}

interface SubagentResult {
	task: string;
	exitCode: number;
	messages: Message[];
	stderr: string;
	usage: UsageStats;
	model?: string;
	stopReason?: string;
	errorMessage?: string;
}

interface SubagentDetails {
	result: SubagentResult;
}

function formatTokens(count: number): string {
	if (count < 1000) return count.toString();
	if (count < 10000) return `${(count / 1000).toFixed(1)}k`;
	if (count < 1000000) return `${Math.round(count / 1000)}k`;
	return `${(count / 1000000).toFixed(1)}M`;
}

function formatUsageStats(usage: UsageStats, model?: string): string {
	const parts: string[] = [];
	if (usage.turns) parts.push(`${usage.turns} turn${usage.turns > 1 ? "s" : ""}`);
	if (usage.input) parts.push(`↑${formatTokens(usage.input)}`);
	if (usage.output) parts.push(`↓${formatTokens(usage.output)}`);
	if (usage.cacheRead) parts.push(`R${formatTokens(usage.cacheRead)}`);
	if (usage.cacheWrite) parts.push(`W${formatTokens(usage.cacheWrite)}`);
	if (usage.cost) parts.push(`$${usage.cost.toFixed(4)}`);
	if (usage.contextTokens > 0) parts.push(`ctx:${formatTokens(usage.contextTokens)}`);
	if (model) parts.push(model);
	return parts.join(" ");
}

function formatToolCall(
	toolName: string,
	args: Record<string, unknown>,
	themeFg: (color: any, text: string) => string,
): string {
	const shortenPath = (p: string) => {
		const home = os.homedir();
		return p.startsWith(home) ? `~${p.slice(home.length)}` : p;
	};

	switch (toolName) {
		case "bash": {
			const command = (args.command as string) || "...";
			const preview = command.length > 60 ? `${command.slice(0, 60)}...` : command;
			return themeFg("muted", "$ ") + themeFg("toolOutput", preview);
		}
		case "read": {
			const filePath = shortenPath((args.path || args.file_path || "...") as string);
			return themeFg("muted", "read ") + themeFg("accent", filePath);
		}
		case "write": {
			const filePath = shortenPath((args.path || args.file_path || "...") as string);
			const lines = ((args.content || "") as string).split("\n").length;
			return themeFg("muted", "write ") + themeFg("accent", filePath) + themeFg("dim", ` (${lines} lines)`);
		}
		case "edit": {
			const filePath = shortenPath((args.path || args.file_path || "...") as string);
			return themeFg("muted", "edit ") + themeFg("accent", filePath);
		}
		case "ls":
			return themeFg("muted", "ls ") + themeFg("accent", shortenPath((args.path || ".") as string));
		case "find":
			return (
				themeFg("muted", "find ") +
				themeFg("accent", (args.pattern || "*") as string) +
				themeFg("dim", ` in ${shortenPath((args.path || ".") as string)}`)
			);
		case "grep":
			return (
				themeFg("muted", "grep ") +
				themeFg("accent", `/${(args.pattern || "") as string}/`) +
				themeFg("dim", ` in ${shortenPath((args.path || ".") as string)}`)
			);
		default: {
			const argsStr = JSON.stringify(args);
			const preview = argsStr.length > 50 ? `${argsStr.slice(0, 50)}...` : argsStr;
			return themeFg("accent", toolName) + themeFg("dim", ` ${preview}`);
		}
	}
}

function getFinalOutput(messages: Message[]): string {
	for (let i = messages.length - 1; i >= 0; i--) {
		const msg = messages[i];
		if (msg.role === "assistant") {
			for (const part of msg.content) {
				if (part.type === "text") return part.text;
			}
		}
	}
	return "";
}

function isFailed(result: SubagentResult): boolean {
	return result.exitCode !== 0 || result.stopReason === "error" || result.stopReason === "aborted";
}

function truncateOutput(output: string): string {
	const byteLength = Buffer.byteLength(output, "utf8");
	if (byteLength <= OUTPUT_CAP) return output;

	let truncated = output.slice(0, OUTPUT_CAP);
	while (Buffer.byteLength(truncated, "utf8") > OUTPUT_CAP) {
		truncated = truncated.slice(0, -1);
	}
	return `${truncated}\n\n[Output truncated: ${byteLength - Buffer.byteLength(truncated, "utf8")} bytes omitted. If you need the omitted content, delegate a follow-up task that extracts the specific parts you need.]`;
}

type DisplayItem = { type: "text"; text: string } | { type: "toolCall"; name: string; args: Record<string, any> };

function getDisplayItems(messages: Message[]): DisplayItem[] {
	const items: DisplayItem[] = [];
	for (const msg of messages) {
		if (msg.role === "assistant") {
			for (const part of msg.content) {
				if (part.type === "text") items.push({ type: "text", text: part.text });
				else if (part.type === "toolCall") items.push({ type: "toolCall", name: part.name, args: part.arguments });
			}
		}
	}
	return items;
}

/** Resolve how to invoke pi so this works whether pi runs via node, bun, or a compiled binary. */
function getPiInvocation(args: string[]): { command: string; args: string[] } {
	const currentScript = process.argv[1];
	const isBunVirtualScript = currentScript?.startsWith("/$bunfs/root/");
	if (currentScript && !isBunVirtualScript && fs.existsSync(currentScript)) {
		return { command: process.execPath, args: [currentScript, ...args] };
	}

	const execName = path.basename(process.execPath).toLowerCase();
	const isGenericRuntime = /^(node|bun)(\.exe)?$/.test(execName);
	if (!isGenericRuntime) {
		return { command: process.execPath, args };
	}

	return { command: "pi", args };
}

async function runSubagent(
	task: string,
	cwd: string,
	model: string | undefined,
	tools: string[] | undefined,
	signal: AbortSignal | undefined,
	onUpdate: ((partial: AgentToolResult<SubagentDetails>) => void) | undefined,
): Promise<SubagentResult> {
	const args: string[] = ["--mode", "json", "-p", "--no-session"];
	if (model) args.push("--model", model);
	if (tools && tools.length > 0) args.push("--tools", tools.join(","));

	const result: SubagentResult = {
		task,
		exitCode: 0,
		messages: [],
		stderr: "",
		usage: { input: 0, output: 0, cacheRead: 0, cacheWrite: 0, cost: 0, contextTokens: 0, turns: 0 },
		model,
	};

	const emitUpdate = () => {
		if (onUpdate) {
			onUpdate({
				content: [{ type: "text", text: getFinalOutput(result.messages) || "(running...)" }],
				details: { result },
			});
		}
	};

	args.push(task);
	let wasAborted = false;

	const exitCode = await new Promise<number>((resolve) => {
		const invocation = getPiInvocation(args);
		const proc = spawn(invocation.command, invocation.args, {
			cwd,
			shell: false,
			stdio: ["ignore", "pipe", "pipe"],
			env: { ...process.env, PI_SUBAGENT: "1" },
		});
		let buffer = "";

		const processLine = (line: string) => {
			if (!line.trim()) return;
			let event: any;
			try {
				event = JSON.parse(line);
			} catch {
				return;
			}

			if (event.type === "message_end" && event.message) {
				const msg = event.message as Message;
				result.messages.push(msg);

				if (msg.role === "assistant") {
					result.usage.turns++;
					const usage = msg.usage;
					if (usage) {
						result.usage.input += usage.input || 0;
						result.usage.output += usage.output || 0;
						result.usage.cacheRead += usage.cacheRead || 0;
						result.usage.cacheWrite += usage.cacheWrite || 0;
						result.usage.cost += usage.cost?.total || 0;
						result.usage.contextTokens = usage.totalTokens || 0;
					}
					if (!result.model && msg.model) result.model = msg.model;
					if (msg.stopReason) result.stopReason = msg.stopReason;
					if (msg.errorMessage) result.errorMessage = msg.errorMessage;
				}
				emitUpdate();
			}

			if (event.type === "tool_result_end" && event.message) {
				result.messages.push(event.message as Message);
				emitUpdate();
			}
		};

		proc.stdout.on("data", (data) => {
			buffer += data.toString();
			const lines = buffer.split("\n");
			buffer = lines.pop() || "";
			for (const line of lines) processLine(line);
		});

		proc.stderr.on("data", (data) => {
			result.stderr += data.toString();
		});

		proc.on("close", (code) => {
			if (buffer.trim()) processLine(buffer);
			resolve(code ?? 0);
		});

		proc.on("error", () => {
			resolve(1);
		});

		if (signal) {
			const killProc = () => {
				wasAborted = true;
				proc.kill("SIGTERM");
				setTimeout(() => {
					if (!proc.killed) proc.kill("SIGKILL");
				}, 5000);
			};
			if (signal.aborted) killProc();
			else signal.addEventListener("abort", killProc, { once: true });
		}
	});

	result.exitCode = exitCode;
	if (wasAborted) throw new Error("Subagent was aborted");
	return result;
}

const SubagentParams = Type.Object({
	task: Type.String({
		description:
			"Complete, self-contained task description for the subagent. It has no access to this conversation, " +
			"so include all necessary context: relevant file paths, what to look for, and what to report back.",
	}),
	cwd: Type.Optional(
		Type.String({ description: "Working directory for the subagent process. Defaults to the current directory." }),
	),
	model: Type.Optional(Type.String({ description: "Model override for the subagent (e.g. a cheaper/faster model)." })),
	tools: Type.Optional(
		Type.Array(Type.String(), {
			description: 'Restrict the subagent to these tools (e.g. ["read", "grep", "find", "ls"]). Default: all tools.',
		}),
	),
});

export default function (pi: ExtensionAPI) {
	// Recursion guard: subagent processes must not be able to spawn further subagents.
	if (process.env.PI_SUBAGENT === "1") return;

	pi.registerTool({
		name: "subagent",
		label: "Subagent",
		description: [
			"Delegate a task to a subagent running in a separate pi process with its own isolated context window.",
			"The subagent has the same tools and default model, but only its final output is returned to you.",
			"Use this for context-heavy work whose intermediate output would pollute your context: broad codebase exploration, reading many files, analyzing logs, mass searches, etc.",
			"Do NOT use it for tasks you can do with a few direct tool calls, or tasks that need back-and-forth interaction.",
			"The task must be fully self-contained: the subagent cannot see this conversation, so include all relevant context, file paths, and clearly state what final output you expect back.",
		].join(" "),
		parameters: SubagentParams,

		async execute(_toolCallId, params, signal, onUpdate, ctx) {
			const result = await runSubagent(
				params.task,
				params.cwd ?? ctx.cwd,
				params.model,
				params.tools,
				signal,
				onUpdate,
			);

			if (isFailed(result)) {
				const errorMsg = result.errorMessage || result.stderr || getFinalOutput(result.messages) || "(no output)";
				// Throw to mark the tool result as failed: pi drops `isError: true` from
				// returned values (only throw sets it). Details are emptied on thrown
				// errors, so renderResult falls back to plain text — see its guard.
				throw new Error(`Subagent ${result.stopReason || "failed"}: ${truncateOutput(errorMsg)}`);
			}

			return {
				content: [{ type: "text", text: truncateOutput(getFinalOutput(result.messages) || "(no output)") }],
				details: { result } satisfies SubagentDetails,
			};
		},

		renderCall(args, theme) {
			const preview = args.task ? (args.task.length > 80 ? `${args.task.slice(0, 80)}...` : args.task) : "...";
			let text = theme.fg("toolTitle", theme.bold("subagent "));
			if (args.model) text += theme.fg("muted", `[${args.model}] `);
			text += `\n  ${theme.fg("dim", preview)}`;
			return new Text(text, 0, 0);
		},

		renderResult(result, { expanded }, theme) {
			const details = result.details as SubagentDetails | undefined;
			const r = details?.result;
			if (!r) {
				// Fallback for results without structured details (e.g. thrown errors,
				// where details is empty): show the raw content, with an error marker
				// when the message-level isError flag is set.
				const text = result.content[0];
				const textStr = text?.type === "text" ? text.text : "(no output)";
				const prefix = result.isError ? theme.fg("error", "✗ ") : "";
				return new Text(prefix + textStr, 0, 0);
			}
			const failed = isFailed(r);
			const icon = failed ? theme.fg("error", "✗") : theme.fg("success", "✓");
			const displayItems = getDisplayItems(r.messages);
			const finalOutput = getFinalOutput(r.messages);
			const header = `${icon} ${theme.fg("toolTitle", theme.bold("subagent"))}${failed && r.stopReason ? ` ${theme.fg("error", `[${r.stopReason}]`)}` : ""}`;
			const usageStr = formatUsageStats(r.usage, r.model);

			if (expanded) {
				const mdTheme = getMarkdownTheme();
				const container = new Container();
				container.addChild(new Text(header, 0, 0));
				if (failed && r.errorMessage) {
					container.addChild(new Text(theme.fg("error", `Error: ${r.errorMessage}`), 0, 0));
				}
				container.addChild(new Spacer(1));
				container.addChild(new Text(theme.fg("muted", "─── Task ───"), 0, 0));
				container.addChild(new Text(theme.fg("dim", r.task), 0, 0));
				container.addChild(new Spacer(1));
				container.addChild(new Text(theme.fg("muted", "─── Output ───"), 0, 0));
				for (const item of displayItems) {
					if (item.type === "toolCall") {
						container.addChild(
							new Text(theme.fg("muted", "→ ") + formatToolCall(item.name, item.args, theme.fg.bind(theme)), 0, 0),
						);
					}
				}
				if (finalOutput) {
					container.addChild(new Spacer(1));
					container.addChild(new Markdown(finalOutput.trim(), 0, 0, mdTheme));
				}
				if (usageStr) {
					container.addChild(new Spacer(1));
					container.addChild(new Text(theme.fg("dim", usageStr), 0, 0));
				}
				return container;
			}

			let text = header;
			if (failed && r.errorMessage) text += `\n${theme.fg("error", `Error: ${r.errorMessage}`)}`;
			else if (displayItems.length === 0) text += `\n${theme.fg("muted", "(no output)")}`;
			else {
				const toShow = displayItems.slice(-COLLAPSED_ITEM_COUNT);
				const skipped = displayItems.length - toShow.length;
				if (skipped > 0) text += `\n${theme.fg("muted", `... ${skipped} earlier items`)}`;
				for (const item of toShow) {
					if (item.type === "text") {
						const preview = item.text.split("\n").slice(0, 3).join("\n");
						text += `\n${theme.fg("toolOutput", preview)}`;
					} else {
						text += `\n${theme.fg("muted", "→ ") + formatToolCall(item.name, item.args, theme.fg.bind(theme))}`;
					}
				}
				if (displayItems.length > COLLAPSED_ITEM_COUNT) text += `\n${theme.fg("muted", "(Ctrl+O to expand)")}`;
			}
			if (usageStr) text += `\n${theme.fg("dim", usageStr)}`;
			return new Text(text, 0, 0);
		},
	});
}
