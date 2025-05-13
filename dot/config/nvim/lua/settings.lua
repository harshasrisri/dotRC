local disabled_built_ins = {
  "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers",
  "gzip", "zip", "zipPlugin", "tar", "tarPlugin",
  "getscript", "getscriptPlugin",
  "2html_plugin", "logipat", "rrhelper", "spellfile_plugin", "matchit",
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

vim.g.mapleader       = " "                      -- Space is the leader key
vim.g.maplocalleader  = " "                      -- Space is the local leader key
vim.opt.autoread      = true                     -- Auto reload files changed outside vim
vim.opt.backspace     = { 'indent', 'eol', 'start' } -- Backspace works over whitespaces also
vim.opt.backupdir:remove(".")                    -- Don't store backup files in a file's $PWD
vim.opt.completeopt   = { 'menu', 'menuone', 'noselect' } -- completion option selection behavior
vim.opt.cursorline    = true                     -- Horizontal line to indicate cursor
vim.opt.diffopt       = "internal,filler,closeoff,indent-heuristic,linematch:60,algorithm:histogram"
vim.opt.expandtab     = true                     -- Insert 4 spaces when Tab is pressed
vim.opt.formatoptions:append("rn")               -- Auto comment new comment lines, indents for numbered lists
vim.opt.foldlevel     = 99                       -- Fold levels
vim.opt.foldmethod    = 'expr'                   -- Fold based on treesitter's fold expr
vim.opt.foldexpr      = 'nvim_treesitter#foldexpr()'
vim.opt.grepprg       = 'rg --vimgrep'           -- use ripgrep's vim mode as grep program
vim.opt.hidden        = true                     -- Hide closed buffers instead of closing them.
vim.opt.ignorecase    = true                     -- Ignore case while searching
vim.opt.inccommand    = 'nosplit'                -- Interactive search and replace
vim.opt.linebreak     = true                     -- Prevents breaking line mid-word when wrapped
vim.opt.mouse         = 'a'                      -- Enable Mouse in all modes
vim.opt.number        = true                     -- Show line number in gutter
vim.opt.ruler         = false                    -- Disable showing the ruler
vim.opt.scrolloff     = 5                        -- Nun lines to keep top and bottom of a window while scrolling
vim.opt.shiftwidth    = 4                        -- Auto indent shifts 4 spaces
vim.opt.showmode      = false                    -- Don't show mode on command line
vim.opt.sidescrolloff = 5                        -- Num lines to keep left and right of a window while scrolling
vim.opt.signcolumn    = 'yes'                    -- Always show signcolumn for gitsigns, diagnostics, etc
vim.opt.smartcase     = true                     -- Ignore case if searching lowercase, not otherwise
vim.opt.smartindent   = true                     --
vim.opt.splitbelow    = true                     -- Open a new split below the current one
vim.opt.splitright    = true                     -- Open a new vertical split to the right of the current one
vim.opt.tabstop       = 4                        -- Show a tabstop as 4 spaces
vim.opt.termguicolors = true                     -- Set terminal to true colors
vim.opt.timeoutlen    = 400                      -- Time interval to wait for mapped sequence to complete
vim.opt.undofile      = true                     -- Remember undo history for closed files
vim.opt.updatetime    = 100                      -- Time interval to update windows
vim.opt.wildmenu      = true                     -- Pressing tab in command mode shows options on status bar
vim.opt.wildmode      = 'longest:full,full'      -- Longest completion in wildmenu
vim.opt.wildignore    = '*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx,*DS_STORE,*.db'
vim.opt.winborder     = 'rounded'

if vim.fn.has('gui_running') then
    vim.opt.guifont                             = 'IosevkaTerm Nerd Font:h16:w1.1'  -- Font to use for GUIs like Neovide
end

if vim.g.neovide then
    vim.g.neovide_scroll_animation_length       = 0.1
    vim.g.neovide_refresh_rate                  = 120
    vim.g.neovide_cursor_animation_length       = 0.05
    vim.g.neovide_cursor_short_animation_length = 0.02
    vim.g.neovide_cursor_trail_size             = 0.25
    vim.g.neovide_cursor_vfx_mode               = "pixiedust"
end

local is_tmux_session = vim.env.TERM_PROGRAM == "tmux" -- Tmux is its own clipboard provider which directly works.
if vim.env.SSH_CONNECTION and not is_tmux_session then
    local function paste() return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") } end
    local osc52 = require("vim.ui.clipboard.osc52")
    vim.g.clipboard = {
        name  = 'OSC 52',
        copy  = { ['+'] = osc52.copy, ['*'] = osc52.copy },
        paste = { ['+'] = paste,      ['*'] = paste },
    }
end

-- Set borders for all floating windows globally
vim.cmd [[autocmd ColorScheme * highlight FloatBorder guifg=white ]]
