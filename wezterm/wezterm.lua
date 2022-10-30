local wezterm = require("wezterm")

return {
	-- to see font config, use command: wezterm ls-fonts [--list-system]
	-- for 13-inch
	font_size = 17.6,
	font = wezterm.font(
		"SauceCodePro Nerd Font Mono",
		{ weight = "DemiBold", stretch = "Normal", style = "Normal" }
	),

	window_decorations = "RESIZE",
	hide_tab_bar_if_only_one_tab = true,

	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
}
