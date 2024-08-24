local wezterm = require("wezterm")
local function init(config)
    local color_scheme, _ = wezterm.color.load_scheme(wezterm.home_dir .. "/.config/wezterm/oxide.toml")
    config.color_schemes = {
        ["Oxide"] = color_scheme,
    }
    config.color_scheme = 'Oxide'

    config.font_size = 16
    config.font = wezterm.font {
        family = 'IosevkaTerm Nerd Font Propo',
        stretch = 'ExtraCondensed',
    }

    config.tab_bar_at_bottom = true
    config.window_padding = { left = 1, right = 1, top = 1, bottom = 1 }
    config.bold_brightens_ansi_colors = true
    config.window_decorations = "RESIZE"

    wezterm.on('update-right-status', function(window, _)
        local name = window:active_key_table()
        if name then
            name = 'TABLE: ' .. name
        end
    end)
end

return init
