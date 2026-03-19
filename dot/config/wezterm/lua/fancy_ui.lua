local wezterm = require("wezterm")

-- Cache color scheme at module level
local color_scheme, _ = wezterm.color.load_scheme(wezterm.home_dir .. "/.config/wezterm/oxide.toml")

local function format_segment(bg, fg, text, intensity, italic)
    return {
        { Background = { Color = bg } },
        { Foreground = { Color = fg } },
        { Attribute = { Intensity = intensity } },
        { Attribute = { Italic = italic } },
        { Text = ' ' .. text .. ' ' },
    }
end

local function set_window_title()
    wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
        local success, result = pcall(function()
            local util = require('util')

            local cwd = tab.active_pane.current_working_dir
            local cwd_str = ''
            if cwd then
                local cwd_path = cwd.file_path or cwd
                if type(cwd_path) == 'string' then
                    cwd_str = util.smart_cwd(cwd_path, wezterm.home_dir)
                end
            end

            local process = util.basename(tab.active_pane.foreground_process_name) or 'shell'

            local title = ''
            if cwd_str and #cwd_str > 0 then
                title = string.format('%s - %s', process, cwd_str)
            else
                title = process
            end

            if #tabs > 1 then
                title = string.format('%s [%d/%d]', title, tab.tab_index + 1, #tabs)
            end

            return title
        end)

        if not success then
            wezterm.log_error("Window title format failed: " .. tostring(result))
            return 'WezTerm'
        end
        return result
    end)
end

local function set_status()
    wezterm.on("update-status", function(window, _)
        local success, err = pcall(function()
            local nf = wezterm.nerdfonts

            local pane = window:active_pane()
            local mode = pane:get_user_vars().wezterm_mode

            local left_seg = nf.md_alpha_n_box .. '  NORMAL'
            local left_bg = 'indianred'

            local key_tbl_display = {
                leader_keys  = { label = 'LEADER',  bg = 'indianred',      icon = nf.md_keyboard },
                resize_panes = { label = 'RESIZE',   bg = 'steelblue',      icon = nf.md_resize },
                split_pane   = { label = 'SPLIT',    bg = 'mediumseagreen', icon = nf.md_view_split_vertical },
                quick_select = { label = 'SELECT',   bg = 'mediumpurple',   icon = nf.md_cursor_text },
                copy_mode    = { label = 'COPY',     bg = 'orange',         icon = nf.md_content_copy },
            }

            if mode and mode ~= '' then
                left_seg = nf.md_content_copy .. ' ' .. string.upper(mode)
                left_bg = 'orange'
            else
                local key_tbl = window:active_key_table()
                if key_tbl then
                    local display = key_tbl_display[key_tbl]
                    if display then
                        left_seg = display.icon .. ' ' .. display.label
                        left_bg = display.bg
                    else
                        left_seg = nf.md_table_of_contents .. ' ' .. string.upper(key_tbl):gsub('_', ' ')
                        left_bg = 'purple'
                    end
                end
            end

            window:set_left_status(wezterm.format(format_segment(left_bg, 'black', left_seg, 'Normal', false)))

            local util = require('util')
            local cwd = window:active_pane():get_current_working_dir()
            local cwd_str = nf.md_home
            if cwd then
                local cwd_path = cwd.file_path or tostring(cwd)
                if type(cwd_path) == 'string' then
                    local smart = util.smart_cwd(cwd_path, wezterm.home_dir)
                    if smart == '~' then
                        cwd_str = nf.md_home
                    else
                        cwd_str = smart
                    end
                end
            end

            local colors = { 'gold', 'orange', 'indianred' }
            local segments = {
                nf.cod_folder .. '  ' .. cwd_str,
                nf.cod_calendar .. ' ' .. wezterm.strftime('%a %b %-d'),
                nf.fa_clock_o .. ' ' .. wezterm.strftime('%H:%M:%S'),
            }

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
    local nf = wezterm.nerdfonts

    config.colors = {
        tab_bar = {
            background = '#222222',
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
    config.max_fps = 120
    config.color_schemes = {
        ["Oxide"] = color_scheme,
    }
    config.color_scheme = 'Oxide'
    config.initial_cols = 240
    config.initial_rows = 80
    config.font_size = 15
    config.adjust_window_size_when_changing_font_size = false
    config.font = wezterm.font 'IosevkaTerm Nerd Font Propo'

    config.window_padding = { left = 1, right = 1, top = 1, bottom = 1 }
    config.bold_brightens_ansi_colors = true
    config.window_decorations = "RESIZE"

    config.window_background_opacity = 0.95
    config.macos_window_background_blur = 20

    config.inactive_pane_hsb = {
        saturation = 0.8,
        brightness = 0.6,
    }

    config.tab_bar_at_bottom = false
    config.use_fancy_tab_bar = true
    config.window_frame = {
        font = wezterm.font 'Monaspace Neon Nerd Font',
        font_size = 12,
        active_titlebar_bg = '#222222',
        inactive_titlebar_bg = '#222222',
    }

    config.hyperlink_rules = {
        { regex = '\\b\\w+://[\\w.-]+\\S*\\b', format = '$0' },
        { regex = [[\b(/[a-zA-Z0-9._-]+)+\b]], format = '$0' },
        { regex = [[\b([a-zA-Z0-9._/-]+):(\d+)\b]], format = '$0' },
        { regex = [[\b[a-f0-9]{7,40}\b]], format = 'https://github.com/search?q=$0&type=commits' },
        { regex = [[\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}(:\d+)?\b]], format = '$0' },
        { regex = [[\b[A-Z]+-\d+\b]], format = '$0' },
        { regex = [[\b\w+@[\w-]+\.[\w.-]+\b]], format = 'mailto:$0' },
    }

    format_tab_bar(config)
    set_window_title()
    set_status()
end

return init
