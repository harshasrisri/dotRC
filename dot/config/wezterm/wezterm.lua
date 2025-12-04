local wezterm = require("wezterm");

package.path = package.path .. ";" .. wezterm.config_dir .. "/lua/?.lua"

local config = wezterm.config_builder()

config.status_update_interval = 1000
config.scrollback_lines = 100000

require("ui")(config)
require("keymap")(config)

local status, local_config = pcall(require, "local")
if status then
    local_config.init(config)
end

wezterm.on('user-var-changed', function(window, pane, name, value)
  if name == 'to_clipboard' then
    window:copy_to_clipboard(value)
    wezterm.log_info('wezcopy: copied ' .. #value .. ' characters to clipboard')
  end
end)

return config
