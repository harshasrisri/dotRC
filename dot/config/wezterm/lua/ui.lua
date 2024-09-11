local wezterm = require("wezterm")
local nf = wezterm.nerdfonts
local Left = 'left'
local Right = 'right'

local function format_element(direction, bg, fg, text, intensity, italic)
    local SOLID_LEFT_SLANT_START = ""
    local SOLID_LEFT_SLANT_END = ""

    local SOLID_RIGHT_SLANT_START = ''
    local SOLID_RIGHT_SLANT_END = ''

    local tab_bar_bg = '#222222'

    local start_edge = SOLID_LEFT_SLANT_START
    local end_edge = SOLID_LEFT_SLANT_END

    if direction == Right then
        start_edge = SOLID_RIGHT_SLANT_START
        end_edge = SOLID_RIGHT_SLANT_END
    end

    return {
        { Background = { Color = tab_bar_bg } }, { Foreground = { Color = bg } }, { Attribute = { Intensity = intensity } }, { Attribute = { Italic = italic } },
        { Text = start_edge },
        { Background = { Color = bg } }, { Foreground = { Color = fg } }, { Attribute = { Intensity = intensity } }, { Attribute = { Italic = italic } },
        { Text = ' ' .. text .. ' ' },
        { Background = { Color = tab_bar_bg } }, { Foreground = { Color = bg } }, { Attribute = { Intensity = intensity } }, { Attribute = { Italic = italic } },
        { Text = end_edge },
    }
end

local function set_status()
    wezterm.on("update-status", function(window, _)
        -- Left Status
        local left_seg = nf.md_remote_desktop .. '  Dom: ' .. string.upper(wezterm.mux.get_domain():name())
        local key_tbl = window:active_key_table()
        if key_tbl then
            left_seg = nf.md_table_of_contents .. ' ' .. string.upper(key_tbl):gsub('_', ' ')
        end

        window:set_left_status(wezterm.format(format_element(Left, 'indianred', 'black', left_seg, 'Normal', false)))

        -- Right Status
        local colors = { 'gold', 'orange', 'indianred' }
        local segments = {
            nf.oct_device_desktop .. '  WS: ' .. window:active_workspace(),
            string.format('%s %s %s %s', nf.cod_calendar, wezterm.strftime('%a %b %-d'), nf.fa_clock_o, wezterm.strftime('%H:%M:%S')),
            'Wez ' .. nf.dev_terminal
        }

        local right_elements = {}
        for i, segment in ipairs(segments) do
            local right_seg = format_element(Right, colors[i], 'black', segment, 'Normal', false)
            for _, item in ipairs(right_seg) do
                table.insert(right_elements, item)
            end
        end
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
        new_tab = wezterm.format( format_element(Left, '#444444', 'black', nf.cod_add .. ' ', 'Normal', false) ),
        new_tab_hover = wezterm.format( format_element(Left, '#CCCCCC', 'black', '+', 'Bold', false) ),
    }

    wezterm.on('format-tab-title', function(tab, _, _, _, hover, max_width)
        local tab_id = tonumber(tab.tab_index) + 1
        local tab_info = require('util').basename(tab.active_pane.foreground_process_name)
        if #tab_info == 0 then
            tab_info = tab.tab_title
            if tab_info == nil or #tab_info == 0 then
                tab_info = tab.active_pane.title
            end
        end

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

        local tab_title = string.format('%s %s: %s', nf.md_bookshelf, tab_id, tab_info)
        tab_title = wezterm.truncate_right(tab_title, max_width - 4)

        return format_element(Left, tab_bg, tab_fg, tab_title, intensity, italic)
    end)
end

local function init(config)
    local color_scheme, _ = wezterm.color.load_scheme(wezterm.home_dir .. "/.config/wezterm/oxide.toml")
    config.color_schemes = {
        ["Oxide"] = color_scheme,
    }
    config.color_scheme = 'Oxide'

    config.font_size = 15
    config.adjust_window_size_when_changing_font_size = false
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
