local autocmd = vim.api.nvim_create_autocmd;

autocmd('FileType', {
    pattern = '*',
    callback = function()
        -- Disable comment on new line
        vim.opt.formatoptions:remove({ 'c', 'r', 'o' })
    end,
    group = general,
    desc = 'Disable New Line Comment'
})

autocmd('ModeChanged', {
    callback = function()
        if vim.fn.getcmdtype() == '/' or vim.fn.getcmdtype() == '?' then
            vim.opt.hlsearch = true
        else
            vim.opt.hlsearch = false
        end
    end,
    group = general,
    desc = 'Highlighting matched words when searching'
})

autocmd("VimEnter", {
    pattern = "*",
    callback = function()
        vim.cmd([[
            hi Normal      guibg=NONE
            hi NormalNC    guibg=NONE
            "hi EndOfBuffer guibg=NONE ctermbg=NONE
            "hi SignColumn  guibg=NONE ctermbg=NONE
            "hi VertSplit   guibg=NONE ctermbg=NONE
            "hi CursorLine  guibg=NONE ctermbg=NONE
        ]])

        vim.api.nvim_set_hl(0, "CursorLine", { bg = "#1a1a1a" })
    end,
})
