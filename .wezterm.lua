local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

config.font = wezterm.font("FiraCode Nerd Font Mono")
-- Disable Ligatures
config.harfbuzz_features = { "calt=0" }

config.initial_cols = 120
config.initial_rows = 28

-- Tab Bar
config.use_fancy_tab_bar = false
config.tab_max_width = 64
config.colors = {
	tab_bar = {
		background = "#000000",
	},
}

config.font_size = 12
config.color_scheme = "Dark Pastel (Gogh)"

config.default_cursor_style = "SteadyBar"

config.tab_bar_at_bottom = true

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.keys = {
	-- Close Window
	{
		key = "Backspace",
		mods = "CTRL|SHIFT",
		action = act.CloseCurrentPane({ confirm = false }),
	},
	-- Split Pane
	{
		key = "n",
		mods = "CTRL|SHIFT",
		action = act.ActivateKeyTable({
			name = "split_pane",
			timeout_milliseconds = 1000,
		}),
	},
	-- Switch Pane
	{ key = "h", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Right") },
	-- Switch Tab
	{ key = "}", mods = "CTRL|SHIFT", action = act.ActivateTabRelativeNoWrap(1) },
	{ key = "{", mods = "CTRL|SHIFT", action = act.ActivateTabRelativeNoWrap(-1) },
	-- Move Tab
	{ key = "<", mods = "CTRL|SHIFT", action = act.MoveTabRelative(-1) },
	{ key = ">", mods = "CTRL|SHIFT", action = act.MoveTabRelative(1) },
	-- Fullscreen
	{ key = "F11", action = act.ToggleFullScreen },
	-- Font Size
	{ key = "=", mods = "CTRL", action = "DisableDefaultAssignment" },
	{ key = "-", mods = "CTRL", action = "DisableDefaultAssignment" },
	{ key = "=", mods = "CTRL|SHIFT", action = act.IncreaseFontSize },
	{ key = "-", mods = "CTRL|SHIFT", action = act.DecreaseFontSize },
	-- Resizing
	{ key = "UpArrow", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Up", 5 }) },
	{ key = "DownArrow", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Down", 5 }) },
	{ key = "LeftArrow", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Left", 5 }) },
	{ key = "RightArrow", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Right", 5 }) },
}

config.key_tables = {
	-- Split Pane
	split_pane = {
		{ key = "h", mods = "CTRL|SHIFT", action = act.SplitPane({ direction = "Left" }) },
		{ key = "j", mods = "CTRL|SHIFT", action = act.SplitPane({ direction = "Down" }) },
		{ key = "k", mods = "CTRL|SHIFT", action = act.SplitPane({ direction = "Up" }) },
		{ key = "l", mods = "CTRL|SHIFT", action = act.SplitPane({ direction = "Right" }) },
	},
}

-- Windows Powershell Config

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_prog = { "wsl.exe", "-d", "archlinux" }
end

config.allow_win32_input_mode = false

return config
