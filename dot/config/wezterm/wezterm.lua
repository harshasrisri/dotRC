local wezterm = require("wezterm");

package.path = package.path .. ";" .. wezterm.config_dir .. "/lua/?.lua"

local config = wezterm.config_builder()

config.status_update_interval = 100
config.scrollback_lines = 100000

config.unix_domains = { { name = 'local_mux', }, }
config.default_mux_server_domain = 'local_mux'
-- config.term = 'wezterm'

require("ui")(config)
require("keymap")(config)

local status, local_config = pcall(require, "local")
if status then
    local_config.init(config)
end

return config
