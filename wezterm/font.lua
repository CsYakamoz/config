local wezterm = require("wezterm")

-- to see font config, use command: wezterm ls-fonts [--list-system]
return {
	SourceCodePro = wezterm.font(
		"SauceCodePro Nerd Font Mono",
		{ weight = "DemiBold", stretch = "Normal", style = "Normal" }
	),

	IBMPlexMono = wezterm.font(
		"BlexMono Nerd Font Mono",
		{ weight = "DemiBold", stretch = "Normal", style = "Normal" }
	),
}
