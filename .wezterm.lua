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

config.hide_tab_bar_if_only_one_tab = true

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.keys = {
	{ key = "n", mods = "CTRL|SHIFT", action = "DisableDefaultAssignment" },
	{ key = "l", mods = "CTRL|SHIFT", action = "DisableDefaultAssignment" },
	{ key = "p", mods = "CTRL|SHIFT", action = "DisableDefaultAssignment" },
	-- Fullscreen
	{ key = "F11", action = act.ToggleFullScreen },
	-- Font Size
	{ key = "=", mods = "CTRL", action = "DisableDefaultAssignment" },
	{ key = "-", mods = "CTRL", action = "DisableDefaultAssignment" },
	{ key = "=", mods = "CTRL|SHIFT", action = act.IncreaseFontSize },
	{ key = "-", mods = "CTRL|SHIFT", action = act.DecreaseFontSize },
}

-- Windows Powershell Config

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_prog = { "wsl.exe", "-d", "archlinux" }
	config.allow_win32_input_mode = false
end

return config
