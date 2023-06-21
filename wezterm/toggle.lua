local wezterm = require("wezterm")

wezterm.on("toggle-ligature", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if not overrides.harfbuzz_features then
		overrides.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
	else
		overrides.harfbuzz_features = nil
	end

	window:set_config_overrides(overrides)
end)

wezterm.on("toggle-opacity", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if not overrides.window_background_opacity then
		overrides.window_background_opacity = 1.0
	else
		overrides.window_background_opacity = nil
	end

	window:set_config_overrides(overrides)
end)

return {
	keys = {
		{
			key = "l",
			mods = "SUPER",
			action = wezterm.action.EmitEvent("toggle-ligature"),
		},
		{
			key = "u",
			mods = "SUPER",
			action = wezterm.action.EmitEvent("toggle-opacity"),
		},
	},
}
