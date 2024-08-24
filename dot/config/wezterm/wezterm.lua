local wezterm = require("wezterm");

package.path = package.path .. ";" .. wezterm.config_dir .. "/lua/?.lua"

local config = wezterm.config_builder()

require("ui")(config)
require("keymap")(config)

local status, local_config = pcall(require, "local")
if status then
    local_config.init(config)
end

config.unix_domains = { { name = 'unix', }, }

return config
