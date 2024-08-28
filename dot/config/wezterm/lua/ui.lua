local wezterm = require("wezterm")
local Left = 'left'
local Right = 'right'
local Direction = { Left, Right }

local function format_element(direction, bg, fg, text, intensity, italic)
    local SOLID_LEFT_SLANT_START = ""
    local SOLID_LEFT_SLANT_END = ""

    local SOLID_RIGHT_SLANT_START = ''
    local SOLID_RIGHT_SLANT_END = ''

    local tab_bar_bg = '#222222'

    local start_edge, end_edge
    if direction == Direction.Left then
        start_edge = SOLID_LEFT_SLANT_START
        end_edge = SOLID_LEFT_SLANT_END
    else
        start_edge = SOLID_RIGHT_SLANT_START
        end_edge = SOLID_RIGHT_SLANT_END
    end

    return {
        { Background = { Color = tab_bar_bg } }, { Foreground = { Color = bg } }, { Attribute = { Intensity = intensity } }, { Attribute = { Italic = italic } },
        { Text = start_edge },
        { Background = { Color = bg } }, { Foreground = { Color = fg } }, { Attribute = { Intensity = intensity } }, { Attribute = { Italic = italic } },
        { Text = text },
        { Background = { Color = tab_bar_bg } }, { Foreground = { Color = bg } }, { Attribute = { Intensity = intensity } }, { Attribute = { Italic = italic } },
        { Text = end_edge },
    }
end

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
            local right_seg = format_element(Direction.Right, colors[i], 'black', seg, 'Normal', false)
            for item in right_seg do
                table.insert(right_elements, item)
            end
        end

        local left_seg = '  ' .. wezterm.nerdfonts.dev_terminal .. ' WezTerm '
        local left_elemen = format_element(Direction.Left, 'indianred', 'black', left_seg, 'Normal', false)

        window:set_left_status(wezterm.format(left_elemen))
        window:set_right_status(wezterm.format(right_elements))

    end)
end

local function format_tab_bar(config)
    config.colors = {
        tab_bar = {
            background = '#222222',
            new_tab = { bg_color = '#444444', fg_color = 'black', },
            new_tab_hover = { bg_color = 'lightcoral', fg_color = 'black', },
        },
    }

    config.tab_bar_style = {
        new_tab = wezterm.format( format_element(Direction.Left, '#444444', 'black', ' + ', 'Normal', false) ),
        new_tab_hover = wezterm.format( format_element(Direction.Left, '#CCCCCC', 'black', ' + ', 'Bold', false) ),
    }

    wezterm.on('format-tab-title', function(tab, _, _, _, hover, max_width)
        local tab_id = tonumber(tab.tab_index) + 1
        local procname = require('util').basename(tab.active_pane.foreground_process_name)

        local tab_bg = 'black'
        local tab_fg = 'coral'
        local intensity = 'Normal'
        local italic = true

        if tab.is_active then
            tab_bg = 'coral'
            tab_fg = 'black'
            intensity = 'Bold'
            italic = false
        elseif hover then
            tab_fg = '#444444'
            tab_bg = 'lightgoldenrod'
            intensity = 'Normal'
            italic = false
        end

        local title = string.format(' %s: %s ', tab_id, procname)
        title = wezterm.truncate_right(title, max_width - 2)

        return format_element(Direction.Left, tab_bg, tab_fg, title, intensity, italic)
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
