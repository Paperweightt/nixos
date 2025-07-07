local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Gruvbox"
config.font = wezterm.font("JetBrains Mono")
config.font_size = 10.5

config.default_prog = { "pwsh.exe" }

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.7

return config
