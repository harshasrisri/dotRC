require('settings')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({ "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
    -- defaults = { lazy = true },
    git = { log = { "-2" }, },
    ui = { border = "rounded", },
    checker = { notify = false, },
    performance = {
        rtp = {
            disabled_plugins = {
                "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers",
                "gzip", "zip", "zipPlugin", "tar", "tarPlugin",
                "getscript", "getscriptPlugin", "tutor", "tohtml", "matchparen",
                "2html_plugin", "logipat", "rrhelper", "spellfile_plugin", "matchit",
            },
        },
    },
})

vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function ()
        require('autocmds')
        require('mappings')
    end,
})
