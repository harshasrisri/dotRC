local wezterm = require("wezterm")
local action = wezterm.action

local function map(key, mods, fn)
    return { key = key, mods = mods, action = fn }
end

local function init(config)
    local backtick = '`'

    -- Helper function to check if SSH is running in the current pane
    local function is_ssh_running(pane)
        local process_name = pane:get_foreground_process_name()
        if process_name then
            return process_name:find("ssh") ~= nil
        end
        return false
    end

    config.keys = {
        -- Override bare backtick to conditionally activate leader or pass through
        {
            key = backtick,
            mods = 'NONE',
            action = wezterm.action_callback(function(window, pane)
                if is_ssh_running(pane) then
                    -- SSH detected, send backtick through (for remote tmux)
                    window:perform_action(action.SendKey { key = backtick }, pane)
                else
                    -- No SSH, activate leader key table
                    window:perform_action(action.ActivateKeyTable {
                        name = 'leader_keys',
                        timeout_milliseconds = 1000,
                    }, pane)
                end
            end),
        },
        -- Keep CTRL+backtick as explicit fallback
        map( backtick, 'CTRL', action.ActivateKeyTable { name = 'leader_keys', timeout_milliseconds = 1000 } ),
        map( "Enter", "SHIFT", action{SendString="\x1b\r"}),
    }

    config.key_tables = {
        leader_keys = {
            map( backtick, 'NONE', action.SendKey { key = backtick } ),
            map( 'c', 'NONE', action.SpawnTab('CurrentPaneDomain') ),
            map( 'd', 'NONE', action.DetachDomain('CurrentPaneDomain') ),
            map( 'x', 'NONE', action.CloseCurrentPane { confirm = true } ),
            map( 'z', 'NONE', action.TogglePaneZoomState ),
            map( 'n', 'NONE', action.ActivateTabRelative(1) ),
            map( 'p', 'NONE', action.ActivateTabRelative(-1) ),
            map( '-', 'NONE', action.PaneSelect ),
            map( 'k', 'NONE', action.ActivatePaneDirection('Up') ),
            map( 'j', 'NONE', action.ActivatePaneDirection('Down') ),
            map( 'h', 'NONE', action.ActivatePaneDirection('Left') ),
            map( 'l', 'NONE', action.ActivatePaneDirection('Right') ),
            map( 's', 'NONE', action.ActivateKeyTable { name = 'split_pane' } ),
            map( 'r', 'NONE', action.ActivateKeyTable { name = 'resize_panes', one_shot = false, } ),
            map( 'Space', 'NONE', action.ActivateKeyTable { name = 'quick_select' } ),
            map( 'Escape', 'NONE', action.ActivateCopyMode ),
            map( ';', 'NONE', action.ActivateCommandPalette ),
            map( ':', 'NONE', action.ShowLauncherArgs { flags = 'FUZZY|TABS|DOMAINS|COMMANDS' } ),
        },
        resize_panes = {
            map( 'k', 'NONE', action.AdjustPaneSize { 'Up', 5 } ),
            map( 'j', 'NONE', action.AdjustPaneSize { 'Down', 5 } ),
            map( 'h', 'NONE', action.AdjustPaneSize { 'Left', 5 } ),
            map( 'l', 'NONE', action.AdjustPaneSize { 'Right', 5 } ),
            map( 'Escape', 'NONE', 'PopKeyTable' ),
        },
        split_pane = {
            map( 'k', 'NONE', action.SplitPane { direction = 'Up' } ),
            map( 'j', 'NONE', action.SplitPane { direction = 'Down' } ),
            map( 'l', 'NONE', action.SplitPane { direction = 'Right' } ),
            map( 'h', 'NONE', action.SplitPane { direction = 'Left' } ),
            map( 'K', 'SHIFT', action.SplitPane { direction = 'Up', top_level = true } ),
            map( 'J', 'SHIFT', action.SplitPane { direction = 'Down', top_level = true } ),
            map( 'L', 'SHIFT', action.SplitPane { direction = 'Right', top_level = true } ),
            map( 'H', 'SHIFT', action.SplitPane { direction = 'Left', top_level = true } ),
        },
        quick_select = {
            map( 'y', 'NONE', action.QuickSelectArgs { label = 'Copy Quick Selection'}),
            map( 'u', 'NONE', action.QuickSelectArgs {
                label = 'Open Quick Selection as URI',
                patterns = { -- Match a URL in:
                    -- parens: (URL)       | brackets: [URL]      | curly braces: {URL}  | angle brackets: <URL> | not wrapped in brackets
                    '\\((\\w+://\\S+)\\)', '\\[(\\w+://\\S+)\\]', '\\{(\\w+://\\S+)\\}', '<(\\w+://\\S+)>',      '\\b\\w+://\\S+[)/a-zA-Z0-9-]+',
                },
                action = wezterm.action_callback(function(window, pane)
                    local url = window:get_selection_text_for_pane(pane)
                    wezterm.open_with(url)
                end),
            }),
            map( 'i', 'NONE', action.QuickSelectArgs {
                label = 'Insert Quick Selection',
                action = wezterm.action_callback(function(window, pane)
                    local text = window:get_selection_text_for_pane(pane)
                    pane:send_text(text)
                end)
            }),
            -- Quick select common patterns
            map( 'f', 'NONE', action.QuickSelectArgs {
                label = 'Select File Path',
                patterns = { '\\b(/[a-zA-Z0-9._/-]+)+\\b', '\\b([a-zA-Z0-9._/-]+/[a-zA-Z0-9._/-]+)+\\b' }
            }),
            map( 'h', 'NONE', action.QuickSelectArgs {
                label = 'Select Git Hash',
                patterns = { '\\b[a-f0-9]{7,40}\\b' }
            }),
            map( 'a', 'NONE', action.QuickSelectArgs {
                label = 'Select IP Address',
                patterns = { '\\b\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}(:\\d+)?\\b' }
            }),
            map( 'U', 'SHIFT', action.QuickSelectArgs {
                label = 'Select UUID',
                patterns = { '\\b[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}\\b' }
            }),
        }
    }
end

return init
