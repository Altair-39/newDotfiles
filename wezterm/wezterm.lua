local wezterm = require("wezterm")

-- Import the modular configuration
local colors = require("module.colors")
local appearance = require("module.appearance")
local layout = require("module.layout")

return {
	-- Apply color scheme
	colors = {
		foreground = colors.wal.foreground,
		background = colors.wal.background,
		cursor_bg = colors.wal.cursor,
		ansi = { table.unpack(colors.wal.colors, 1, 8) },
		brights = { table.unpack(colors.wal.colors, 9, 16) },
	},

	-- Apply appearance settings
	font = wezterm.font(appearance.font), -- Use wezterm.font here
	font_size = appearance.font_size,
	window_background_opacity = appearance.window_background_opacity,
	harfbuzz_features = { "calt=1", "clig=1", "dlig=1" },
	-- Apply layout settings
	enable_tab_bar = layout.enable_tab_bar,
	-- Force Wayland mode (important in compositors like niri)
	enable_wayland = true,

	-- Remove padding so it fills as much as possible
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	warn_about_missing_glyphs = false,
	-- Make WezTerm accept arbitrary resizes better
	adjust_window_size_when_changing_font_size = true,
}
