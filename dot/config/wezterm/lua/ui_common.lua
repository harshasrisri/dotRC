local wezterm = require("wezterm")

local M = {}

M.TAB_BAR_BG = '#222222'
M.color_scheme = wezterm.color.load_scheme(wezterm.home_dir .. "/.config/wezterm/oxide.toml")

function M.base_config(config)
    config.max_fps = 120
    config.color_schemes = { ["Oxide"] = M.color_scheme }
    config.color_scheme = 'Oxide'
    config.initial_cols = 240
    config.initial_rows = 80
    config.font_size = 15
    config.adjust_window_size_when_changing_font_size = false
    config.font = wezterm.font 'IosevkaTerm Nerd Font Propo'

    config.window_padding = { left = 1, right = 1, top = 1, bottom = 1 }
    config.bold_brightens_ansi_colors = true

    config.window_background_opacity = 0.95
    config.macos_window_background_blur = 20

    config.inactive_pane_hsb = {
        saturation = 0.8,
        brightness = 0.6,
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
end

function M.set_window_title()
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

-- Returns left_seg, left_bg based on current mode/key table state
function M.resolve_mode(window)
    local nf = wezterm.nerdfonts

    local pane = window:active_pane()
    local mode = pane:get_user_vars().wezterm_mode

    local left_seg = nf.md_alpha_n_box .. '  NORMAL'
    local left_bg = 'indianred'

    local key_tbl_display = {
        leader_keys  = { label = 'LEADER', bg = 'deepskyblue',    icon = nf.md_keyboard },
        resize_panes = { label = 'RESIZE', bg = 'steelblue',      icon = nf.md_resize },
        split_pane   = { label = 'SPLIT',  bg = 'mediumseagreen', icon = nf.md_view_split_vertical },
        quick_select = { label = 'SELECT', bg = 'mediumpurple',   icon = nf.md_cursor_text },
        copy_mode    = { label = 'COPY',   bg = 'orange',         icon = nf.md_content_copy },
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

    return left_seg, left_bg
end

-- Returns cwd_display string (home icon at ~, folder icon + path elsewhere)
function M.resolve_cwd(window)
    local nf = wezterm.nerdfonts
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

    return cwd_str == nf.md_home and cwd_str or nf.cod_folder .. '  ' .. cwd_str
end

-- Returns segments table, colors table for the right status bar
function M.right_status_segments(cwd_display)
    local nf = wezterm.nerdfonts
    return {
        cwd_display,
        nf.cod_calendar .. ' ' .. wezterm.strftime('%a %b %-d'),
        nf.fa_clock_o .. ' ' .. wezterm.strftime('%H:%M:%S'),
    }, { 'gold', 'orange', 'indianred' }
end

-- Returns tab_bg, tab_fg, intensity, italic based on tab state
function M.tab_style(tab, hover)
    local tab_bg = '#2a2020'
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

    return tab_bg, tab_fg, intensity, italic
end

return M
