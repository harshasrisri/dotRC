local wezterm = require("wezterm")

local function init(config)
    local color_scheme, _ = wezterm.color.load_scheme(wezterm.home_dir .. "/.config/wezterm/oxide.toml")
    config.color_schemes = {
        ["Oxide"] = color_scheme,
    }
    config.color_scheme = 'Oxide'

    config.font_size = 16
    config.font = wezterm.font 'IosevkaTerm Nerd Font Propo'

    config.window_padding = { left = 1, right = 1, top = 1, bottom = 1 }
    config.bold_brightens_ansi_colors = true
    config.window_decorations = "RESIZE"

    config.use_fancy_tab_bar = false
    config.tab_max_width = 32

    wezterm.on("update-status", function(window, _)
        local status_generator = require("wez-status-generator.plugin")
        local status = status_generator.generate_left_status({
            sections = {
                {
                    components = { function() return wezterm.hostname() end, },
                    foreground = "black",
                    background = "indianred",
                },
                {
                    components = { function() return window:mux_window():get_workspace() end, },
                    foreground = "black",
                    background = "orange",
                },
            },
            separator = status_generator.section_separators.SLANT_REVERSE,
            hide_empty_sections = true,
        })

        window:set_left_status(status)
    end)

    wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
        local tab_id = tonumber(tab.tab_index) + 1
        local procname = require('util').basename(tab.active_pane.foreground_process_name)
        return string.format(' %s(%s): %s ', tab_id, #panes, procname)
    end)

    wezterm.on("update-status", function(window, _)
        local status_generator = require("wez-status-generator.plugin")
        local status = status_generator.generate_right_status({
            sections = {
                {
                    components = { function() return wezterm.strftime("%H:%M:%S") end, },
                    foreground = "black",
                    background = "orange",
                },
                {
                    components = { function() return wezterm.strftime("%d-%b-%y") end, },
                    foreground = "black",
                    background = "indianred",
                },
            },
            separator = status_generator.section_separators.SLANT_REVERSE,
            hide_empty_sections = true,
        })

        window:set_right_status(status)
    end)
end

return init
