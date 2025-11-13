-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
    group = vim.api.nvim_create_augroup('file_last_pos', { clear = true }),
	callback = function(event)
		local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
		local lcount = vim.api.nvim_buf_line_count(event.buf)

        -- Don't restore position for certain filetypes
        local exclude_ft = { "gitcommit", "gitrebase", "help" }
        if vim.tbl_contains(exclude_ft, vim.bo[event.buf].filetype) then
            return
        end

		if mark[1] > 0 and mark[1] <= lcount then
            vim.api.nvim_win_set_cursor(0, mark)
            vim.schedule(function () vim.cmd("normal! zz") end)
		end
	end,
})

-- Writing mode
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup('writing_mode', { clear = true }),
	pattern = { "gitcommit", "markdown", "text" },
	callback = function()
        vim.g.markdown_fenced_languages = { 'c', 'cpp', 'sh', 'bash', 'rust', 'lua', 'python' }
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
        vim.opt_local.linebreak = true  -- Break lines at word boundaries
        vim.opt_local.breakindent = true  -- Preserve indentation in wrapped lines
	end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = vim.api.nvim_create_augroup('check_file_reload', { clear = true }),
    command = "checktime",
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup('highlight_on_yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd("VimResized", {
    group = vim.api.nvim_create_augroup('resize_splits', { clear = true }),
    callback = function()
        vim.cmd("tabdo wincmd =")
    end,
})

-- open help in vertical split
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("help_vsplit", {clear = true}),
    pattern = "help",
    callback = function()
        vim.cmd("wincmd L")
    end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
    pattern = {
        "PlenaryTestPopup",
        "checkhealth",
        "dbout",
        "gitsigns-blame",
        "grug-far",
        "help",
        "lspinfo",
        "neotest-output",
        "neotest-output-panel",
        "neotest-summary",
        "notify",
        "qf",
        "spectre_panel",
        "startuptime",
        "tsplayground",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", function()
            vim.cmd("close")
            pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
        end, {
            buffer = event.buf,
            silent = true,
            desc = "Quit buffer",
        })
    end,
})
