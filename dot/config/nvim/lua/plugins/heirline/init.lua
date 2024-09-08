return {
    {
        'rebelot/heirline.nvim',
        config = function()
            require('heirline').setup {
                statusline = require('plugins.heirline.statusline')
            }
        end,
    },
}
