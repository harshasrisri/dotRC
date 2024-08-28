local wezterm = require("wezterm")
local SOLID_BOT_LEFT_SLANT = ""
local SOLID_BOT_RIGHT_SLANT = ''

local function set_status()
    wezterm.on("update-status", function(window, _)
        local segments = {
            window:active_workspace(),
            wezterm.strftime('%a %b %-d %H:%M:%S'),
            wezterm.hostname(),
        }
        local colors = { 'gold', 'orange', 'indianred' }

        local right_elements = {}

        for i, seg in ipairs(segments) do
            table.insert(right_elements, { Background = { Color = 'none'}})
            table.insert(right_elements, { Foreground = { Color = colors[i] }})
            table.insert(right_elements, { Text = SOLID_BOT_RIGHT_SLANT})
            table.insert(right_elements, { Foreground = { Color = 'black' }})
            table.insert(right_elements, { Background = { Color = colors[i] }})
            table.insert(right_elements, { Text = string.format(' %s ', seg)})
            if i < #segments then
                table.insert(right_elements, { Foreground = { Color = 'none'}})
                table.insert(right_elements, { Text = SOLID_BOT_RIGHT_SLANT})
            end
        end

        local left_element = {
            { Foreground = { Color = 'black' }},
            { Background = { Color = 'indianred' }},
            { Text = '  ' .. wezterm.nerdfonts.dev_terminal .. ' WezTerm ' },
            { Foreground = { Color = 'indianred'}},
            { Background = { Color = 'none' }},
            { Text = SOLID_BOT_LEFT_SLANT },
            { Foreground = { Color = 'none' }},
            { Text = '  '},
        }

        window:set_left_status(wezterm.format(left_element))
        window:set_right_status(wezterm.format(right_elements))
    end)
end


local function format_tab_bar(config)
    config.colors              = {
        tab_bar                = {
            background         = '#222222',
            new_tab            = { bg_color = '#444444', fg_color = 'black', },
            new_tab_hover      = { bg_color = 'lightcoral', fg_color = 'black', },
        },
    }

    wezterm.on('format-tab-title', function(tab, _, _, _, hover, max_width)
        local tab_id = tonumber(tab.tab_index) + 1
        local procname = require('util').basename(tab.active_pane.foreground_process_name)
        local tab_bar_bg = '#222222'

        local tab_fg = 'black'
        local tab_bg = 'coral'
        local intensity = 'Half'
        local italic = true

        if tab.is_active then
            tab_fg = 'coral'
            tab_bg = 'black'
            intensity = 'Bold'
            italic = false
        elseif hover then
            tab_bg = '#444444'
            tab_fg = 'coral'
            intensity = 'Normal'
            italic = false
        end

        local title = string.format(' %s: %s ', tab_id, procname)
        title = wezterm.truncate_right(title, max_width - 2)

        return {
            { Background = { Color = tab_fg } }, { Foreground = { Color = tab_bar_bg } }, { Attribute = { Intensity = intensity } }, { Attribute = { Italic = italic } },
            { Text = SOLID_BOT_LEFT_SLANT },
            { Background = { Color = tab_fg } }, { Foreground = { Color = tab_bg } }, { Attribute = { Intensity = intensity } }, { Attribute = { Italic = italic } },
            { Text = title },
            { Background = { Color = tab_bar_bg } }, { Foreground = { Color = tab_fg } }, { Attribute = { Intensity = intensity } }, { Attribute = { Italic = italic } },
            { Text = SOLID_BOT_LEFT_SLANT },
        }
    end)
end

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

    format_tab_bar(config)
    set_status()
end

return init
