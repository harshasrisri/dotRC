local wezterm = require("wezterm")
local Left = 'left'
local Right = 'right'

-- Cache color scheme at module level
local color_scheme, _ = wezterm.color.load_scheme(wezterm.home_dir .. "/.config/wezterm/oxide.toml")

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
        { Background = { Color = bg } }, { Foreground = { Color = fg } },
        { Text = ' ' .. text .. ' ' },
        { Background = { Color = tab_bar_bg } }, { Foreground = { Color = bg } },
        { Text = end_edge },
    }
end

local function set_window_title()
    wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
        local success, result = pcall(function()
            local util = require('util')

            -- Get working directory
            local cwd = tab.active_pane.current_working_dir
            local cwd_str = ''
            if cwd then
                local cwd_path = cwd.file_path or cwd
                if type(cwd_path) == 'string' then
                    cwd_str = util.smart_cwd(cwd_path, wezterm.home_dir)
                end
            end

            -- Get process name
            local process = util.basename(tab.active_pane.foreground_process_name) or 'shell'

            -- Build title with both cwd and process
            local title = ''
            if cwd_str and #cwd_str > 0 then
                title = string.format('%s - %s', process, cwd_str)
            else
                title = process
            end

            -- Show tab count if multiple tabs
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
            -- Lazy-load nerd fonts only when needed
            local nf = wezterm.nerdfonts

            -- Left Status - Show mode indicators
            local domain = wezterm.mux.get_domain()
            local domain_name = domain and domain:name() or 'unknown'
            local left_seg = nf.md_remote_desktop .. '  Dom: ' .. string.upper(domain_name)
            local left_bg = 'indianred'

            -- Check for copy mode or other pane modes
            local pane = window:active_pane()
            local mode = pane:get_user_vars().wezterm_mode

            if mode and mode ~= '' then
                -- Show mode prominently (e.g., COPY, SEARCH)
                left_seg = nf.md_content_copy .. ' ' .. string.upper(mode)
                left_bg = 'orange'
            else
                -- Check for active key table
                local key_tbl = window:active_key_table()
                if key_tbl then
                    left_seg = nf.md_table_of_contents .. ' ' .. string.upper(key_tbl):gsub('_', ' ')
                    left_bg = 'purple'
                end
            end

            window:set_left_status(wezterm.format(format_element(Left, left_bg, 'black', left_seg, 'Normal', false)))

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

        if not success then
            wezterm.log_error("Status update failed: " .. tostring(err))
        end
    end)
end

local function format_tab_bar(config)
    -- Lazy-load nerd fonts for tab bar styling
    local nf = wezterm.nerdfonts

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
        local success, result = pcall(function()
            -- Lazy-load nerd fonts only when needed
            local nf = wezterm.nerdfonts

            local tab_id = tonumber(tab.tab_index) + 1
            local util = require('util')

            -- Get working directory
            local cwd = tab.active_pane.current_working_dir
            local cwd_str = ''
            if cwd then
                local cwd_path = cwd.file_path or cwd
                if type(cwd_path) == 'string' then
                    cwd_str = util.smart_cwd(cwd_path, wezterm.home_dir)
                end
            end

            -- Get process name
            local process = util.basename(tab.active_pane.foreground_process_name) or 'shell'

            -- Build tab info with both process and cwd
            local tab_info = ''
            if cwd_str and #cwd_str > 0 then
                tab_info = string.format('%s(%s)', process, cwd_str)
            else
                -- Fallback to process name only
                tab_info = process
                if not tab_info or #tab_info == 0 then
                    tab_info = tab.tab_title
                    if not tab_info or #tab_info == 0 then
                        tab_info = tab.active_pane.title or 'unknown'
                    end
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
    config.window_decorations = "TITLE | RESIZE"

    -- Window background opacity and blur
    config.window_background_opacity = 0.95
    config.macos_window_background_blur = 20

    -- Inactive pane dimming for better visual focus
    config.inactive_pane_hsb = {
        saturation = 0.8,
        brightness = 0.6,
    }

    config.tab_bar_at_bottom = true
    config.use_fancy_tab_bar = false
    config.tab_max_width = 40

    -- Clickable hyperlinks detection
    config.hyperlink_rules = {
        -- Standard URLs (http, https, ftp, etc)
        { regex = '\\b\\w+://[\\w.-]+\\S*\\b', format = '$0' },

        -- File paths (absolute)
        { regex = [[\b(/[a-zA-Z0-9._-]+)+\b]], format = '$0' },

        -- File paths with line numbers (file.txt:123)
        { regex = [[\b([a-zA-Z0-9._/-]+):(\d+)\b]], format = '$0' },

        -- Git commit hashes (7-40 hex chars)
        { regex = [[\b[a-f0-9]{7,40}\b]], format = 'https://github.com/search?q=$0&type=commits' },

        -- IPv4 addresses
        { regex = [[\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}(:\d+)?\b]], format = '$0' },

        -- Jira-style tickets (ABC-1234)
        { regex = [[\b[A-Z]+-\d+\b]], format = '$0' },

        -- Email addresses
        { regex = [[\b\w+@[\w-]+\.[\w.-]+\b]], format = 'mailto:$0' },
    }

    format_tab_bar(config)
    set_window_title()
    set_status()
end

return init
