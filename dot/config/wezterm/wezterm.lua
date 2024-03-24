local wezterm = require("wezterm");

-- Start Maximized
local mux = wezterm.mux
wezterm.on('gui-startup', function(cmd)
  local _, _, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

local config = {}
if wezterm.config_builder then
    config = wezterm.config_builder()
end

local color_scheme, _ = wezterm.color.load_scheme(wezterm.home_dir .. "/.config/wezterm/oxide.toml")
config.color_schemes = {
    ["Oxide"] = color_scheme,
}
config.color_scheme = 'Oxide'

-- config.term = "wezterm"
config.font_size = 13
config.font = wezterm.font {
    family = 'IosevkaTerm Nerd Font Propo',
    stretch = 'ExtraCondensed',
}
-- config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.window_padding = { left = 1, right = 1, top = 1, bottom = 1 }
config.bold_brightens_ansi_colors = true
-- config.window_decorations = "RESIZE"
-- config.hide_tab_bar_if_only_one_tab = true

return config
