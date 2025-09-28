local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

config.font = wezterm.font("JetBrainsMono Nerd Font")

config.initial_cols = 120
config.initial_rows = 28

config.font_size = 14
config.color_scheme = "carbonfox"

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
	-- Fullscreen
	{ key = "F11", action = act.ToggleFullScreen },
	-- Font Size
	{ key = "=", mods = "CTRL", action = "DisableDefaultAssignment" },
	{ key = "-", mods = "CTRL", action = "DisableDefaultAssignment" },
	{ key = "=", mods = "CTRL|SHIFT", action = act.IncreaseFontSize },
	{ key = "-", mods = "CTRL|SHIFT", action = act.DecreaseFontSize },
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

-- Finally, return the configuration to wezterm:
return config
