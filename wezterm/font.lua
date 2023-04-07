local wezterm = require("wezterm")

local PingFang = { family = "PingFang SC", weight = "Regular", stretch = "Normal", style = "Normal" }

-- to see font config, use command: wezterm ls-fonts [--list-system]
return {
	SourceCodePro = wezterm.font_with_fallback({
		{ family = "SauceCodePro Nerd Font Mono", weight = "DemiBold", stretch = "Normal", style = "Normal" },
		PingFang,
	}),

	IBMPlexMono = wezterm.font_with_fallback({
		{ family = "BlexMono Nerd Font Mono", weight = "DemiBold", stretch = "Normal", style = "Normal" },
		PingFang,
	}),

	Iosevka = wezterm.font_with_fallback({
		{ family = "Iosevka Nerd Font", weight = "DemiBold", stretch = "Normal", style = "Normal" },
		PingFang,
	}),
}
