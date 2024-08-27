local wezterm = require("wezterm")
local SOLID_BOT_LEFT_SLANT = ""
local SOLID_BOT_RIGHT_SLANT = ''

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

    config.tab_bar_at_bottom = true
    config.use_fancy_tab_bar = false
    config.tab_max_width = 32

    wezterm.on('format-tab-title', function(tab, _, _, _, _, _)
        local tab_id = tonumber(tab.tab_index) + 1
        local procname = require('util').basename(tab.active_pane.foreground_process_name)
        return string.format('  %s: %s  ', tab_id, procname)
    end)

    wezterm.on("update-status", function(window, _)
        local segments = {
            window:active_workspace(),
            wezterm.strftime('%a %b %-d %H:%M:%S'),
            wezterm.hostname(),
        }
        local colors = { 'gold', 'orange', 'indianred' }

        local right_elements = {}

        for i, seg in ipairs(segments) do
            local is_first = i == 1
            if is_first then
                table.insert(right_elements, { Background = { Color = 'none'}})
            end
            table.insert(right_elements, { Foreground = { Color = colors[i] }})
            table.insert(right_elements, { Text = SOLID_BOT_RIGHT_SLANT})
            table.insert(right_elements, { Foreground = { Color = 'black' }})
            table.insert(right_elements, { Background = { Color = colors[i] }})
            table.insert(right_elements, { Text = string.format(' %s ', seg)})
        end

        local left_element = {
            { Foreground = { Color = 'black' }},
            { Background = { Color = 'indianred' }},
            { Text = '  WezTerm ' },
            { Foreground = { Color = 'indianred'}},
            { Background = { Color = 'none' }},
            { Text = SOLID_BOT_LEFT_SLANT }
        }

        window:set_left_status(wezterm.format(left_element))
        window:set_right_status(wezterm.format(right_elements))
    end)
end

return init
