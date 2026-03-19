local wezterm = require("wezterm")
local common = require("ui_common")

local Left = 'left'
local Right = 'right'

local function format_element(direction, bg, fg, text, intensity, italic)
    local SOLID_LEFT_SLANT_START = ""
    local SOLID_LEFT_SLANT_END = ""

    local SOLID_RIGHT_SLANT_START = ''
    local SOLID_RIGHT_SLANT_END = ''

    local start_edge = SOLID_LEFT_SLANT_START
    local end_edge = SOLID_LEFT_SLANT_END

    if direction == Right then
        start_edge = SOLID_RIGHT_SLANT_START
        end_edge = SOLID_RIGHT_SLANT_END
    end

    return {
        { Background = { Color = common.TAB_BAR_BG } }, { Foreground = { Color = bg } }, { Attribute = { Intensity = intensity } }, { Attribute = { Italic = italic } },
        { Text = start_edge },
        { Background = { Color = bg } }, { Foreground = { Color = fg } },
        { Text = ' ' .. text .. ' ' },
        { Background = { Color = common.TAB_BAR_BG } }, { Foreground = { Color = bg } },
        { Text = end_edge },
    }
end

local function set_status()
    wezterm.on("update-status", function(window, _)
        local success, err = pcall(function()
            local left_seg, left_bg = common.resolve_mode(window)
            window:set_left_status(wezterm.format(format_element(Left, left_bg, 'black', left_seg, 'Normal', false)))

            local cwd_display = common.resolve_cwd(window)
            local segments, colors = common.right_status_segments(cwd_display)

            local right_elements = {}
            for i, segment in ipairs(segments) do
                local seg = format_element(Right, colors[i], 'black', segment, 'Normal', false)
                for _, item in ipairs(seg) do
                    table.insert(right_elements, item)
                end
            end
            window:set_right_status(wezterm.format(right_elements))
        end)

        if not success then
            wezterm.log_error("Status update failed: " .. tostring(err))
        end
    end)
end

local function format_tab_bar(config)
    local nf = wezterm.nerdfonts

    config.colors = {
        tab_bar = {
            background = common.TAB_BAR_BG,
            new_tab = { bg_color = '#444444', fg_color = 'black' },
            new_tab_hover = { bg_color = 'lightcoral', fg_color = 'black' },
        },
    }

    config.tab_bar_style = {
        new_tab       = wezterm.format(format_element(Left, '#444444', 'black', nf.cod_add .. ' ', 'Normal', false)),
        new_tab_hover = wezterm.format(format_element(Left, '#CCCCCC', 'black', '+', 'Bold', false)),
    }

    wezterm.on('format-tab-title', function(tab, _, _, _, hover, max_width)
        local success, result = pcall(function()
            local nf = wezterm.nerdfonts
            local util = require('util')

            local tab_id = tonumber(tab.tab_index) + 1
            local process = util.basename(tab.active_pane.foreground_process_name) or 'shell'

            local tab_info
            if process == 'ssh' then
                local _, cwd = common.parse_ssh_title(tab.active_pane.title)
                tab_info = nf.md_ssh .. '  ' .. (cwd or 'ssh')
            else
                tab_info = process
                if not tab_info or #tab_info == 0 then
                    tab_info = tab.tab_title
                    if not tab_info or #tab_info == 0 then
                        tab_info = tab.active_pane.title or 'unknown'
                    end
                end
            end

            local tab_bg, tab_fg, intensity, italic = common.tab_style(tab, hover)
            local tab_title = string.format('%s %s %s', tab_id, nf.ple_backslash_separator, tab_info)
            tab_title = wezterm.truncate_right(tab_title, max_width - 4)

            return format_element(Left, tab_bg, tab_fg, tab_title, intensity, italic)
        end)

        if not success then
            wezterm.log_error("Tab title format failed: " .. tostring(result))
            return {}
        end
        return result
    end)
end

local function init(config)
    common.base_config(config)
    config.window_decorations = "TITLE | RESIZE"
    config.tab_bar_at_bottom = true
    config.use_fancy_tab_bar = false
    config.tab_max_width = 40

    format_tab_bar(config)
    common.set_window_title()
    set_status()
end

return init
