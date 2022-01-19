local disabled_built_ins = {
  "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers",
  "gzip", "zip", "zipPlugin", "tar", "tarPlugin",
  "getscript", "getscriptPlugin",
  "2html_plugin", "logipat", "rrhelper", "spellfile_plugin", "matchit",
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

vim.opt.autoread      = true                     -- Auto reload files changed outside vim
vim.opt.backspace     = {'indent','eol','start'} -- Backspace works over whitespaces also
vim.opt.backupdir:remove(".")                    -- Don't store backup files in a file's $PWD
vim.opt.cursorline    = true                     -- Horizontal line to indicate cursor
vim.opt.expandtab     = true                     -- Insert 4 spaces when Tab is pressed
vim.opt.formatoptions:append("rn")               -- Auto comment new comment lines, indents for numbered lists
vim.opt.guifont       = 'MesloLGS NF:h11.5'      -- Use MesloLGS NF font at 11.5pt height for GUIs
vim.opt.hidden        = true                     -- Hide closed buffers instead of closing them.
vim.opt.ignorecase    = true                     -- Ignore case while searching
vim.opt.inccommand    = 'nosplit'                -- Interactive search and replace
vim.opt.linebreak     = true                     -- Prevents breaking line mid-word when wrapped
vim.opt.mouse         = 'a'                      -- Enable Mouse in all modes
vim.opt.number        = true                     -- Show line number in gutter
vim.opt.pastetoggle   = '<F2>'                   -- Toggle prevent unnecessary autoindent on mouse click paste
vim.opt.ruler         = false                    -- Disable showing the ruler
vim.opt.scrolloff     = 5                        -- Nun lines to keep top and bottom of a window while scrolling
vim.opt.shiftwidth    = 4                        -- Auto indent shifts 4 spaces
vim.opt.showmode      = false                    -- Don't show mode on command line
vim.opt.smartcase     = true                     -- Ignore case if searching lowercase, not otherwise
vim.opt.splitbelow    = true                     -- Open a new split below the current one
vim.opt.splitright    = true                     -- Open a new vertical split to the right of the current one
vim.opt.tabstop       = 4                        -- Show a tabstop as 4 spaces
vim.opt.termguicolors = true                     -- Set terminal to true colors
vim.opt.timeoutlen    = 400                      -- Time interval to wait for mapped sequence to complete
vim.opt.undofile      = true                     -- Remember undo history for closed files
vim.opt.updatetime    = 250                      -- Time interval to update windows
vim.opt.wildmenu      = true                     -- Pressing tab in command mode shows options on status bar
vim.opt.wildmode      = 'longest:full,full'      -- Longest completion in wildmenu

vim.api.nvim_exec([[
"" Initializations
let mapleader="\<Space>"               " Setting the global leader key
set fillchars+=vert:▎                  " make the vertical split bar a slim line with no background
hi VertSplit ctermbg=NONE guibg=NONE   " Set split background color to NONE
let g:vimsyn_embed = 'l'               " Enable syntax highlighting for embedded lua
let g:markdown_fenced_languages = ['c', 'cpp', 'sh', 'bash', 'rust']

augroup Initializations
autocmd!
"" Vim jumps to the last known position when reopening a file
au! BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

augroup highlight_yank
autocmd!
autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END
]], false)

-- Set borders for all floating windows globally
vim.cmd [[autocmd ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]
local border = {
    {"╭", "FloatBorder"},
    {"─", "FloatBorder"},
    {"╮", "FloatBorder"},
    {"│", "FloatBorder"},
    {"╯", "FloatBorder"},
    {"─", "FloatBorder"},
    {"╰", "FloatBorder"},
    {"│", "FloatBorder"},
}
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Settings for Symbols Outline plugin
vim.g.symbols_outline = {
    relative_width = false,
    width = 40,
    auto_preview = false,
    auto_close = true,
}
