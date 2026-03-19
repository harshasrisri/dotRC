local wezterm = require("wezterm")
local common = require("ui_common")

local function format_segment(bg, fg, text, intensity, italic)
    return {
        { Background = { Color = bg } },
        { Foreground = { Color = fg } },
        { Attribute = { Intensity = intensity } },
        { Attribute = { Italic = italic } },
        { Text = ' ' .. text .. ' ' },
    }
end

local function set_status()
    wezterm.on("update-status", function(window, _)
        local success, err = pcall(function()
            local left_seg, left_bg = common.resolve_mode(window)
            window:set_left_status(wezterm.format(format_segment(left_bg, 'black', left_seg, 'Normal', false)))

            local cwd_display = common.resolve_cwd(window)
            local segments, colors = common.right_status_segments(cwd_display)

            local right_elements = {}
            for i, segment in ipairs(segments) do
                local seg = format_segment(colors[i], 'black', segment, 'Normal', false)
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
    config.colors = {
        tab_bar = {
            background = common.TAB_BAR_BG,
            inactive_tab_edge = '#444444',
        },
    }

    wezterm.on('format-tab-title', function(tab, _, _, _, hover, max_width)
        local success, result = pcall(function()
            local tab_info = tab.active_pane.title
            if not tab_info or #tab_info == 0 then
                tab_info = tab.tab_title
                if not tab_info or #tab_info == 0 then
                    tab_info = 'unknown'
                end
            end

            local tab_bg, tab_fg, intensity, italic = common.tab_style(tab, hover)
            return format_segment(tab_bg, tab_fg, tab_info, intensity, italic)
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
    config.window_decorations = "RESIZE"
    config.tab_bar_at_bottom = false
    config.use_fancy_tab_bar = true
    config.window_frame = {
        font = wezterm.font 'Monaspace Neon Nerd Font',
        font_size = 12,
        active_titlebar_bg = common.TAB_BAR_BG,
        inactive_titlebar_bg = common.TAB_BAR_BG,
    }

    format_tab_bar(config)
    common.set_window_title()
    set_status()
end

return init
