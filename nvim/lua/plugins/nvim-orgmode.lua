return {
	"nvim-orgmode/orgmode",
	event = "VeryLazy",
	ft = { "org" },
	config = function()
		-- Setup orgmode
		require("orgmode").setup({
			org_agenda_files = "~/org/**/*",
			org_default_notes_file = "~/org/notes.org",
			org_todo_keywords = { "TODO(t)", "INPROGRESS(i)", "BLOCKED(b)", "|", "DONE(d)", "WONTDO(w)" },
			org_capture_templates = {
				j = {
					description = "Journal",
					target = "~/org/journal.org",
					template = "* %?\n%U",
					datetree = {
						tree_type = "day",
					},
				},
			},
		})
	end,
}
