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

-- autocmd({ "ColorScheme", "VimEnter", "OptionSet" }, {
--     callback = function()
--         vim.cmd([[
--             hi Normal       guibg=NONE
--             hi NormalFloat  guibg=NONE
--             hi FloatBorder  guibg=NONE
--             hi LineNr       guibg=NONE
--             hi CursorLineNr guibg=NONE
--             hi NormalNC     guibg=NONE
--             hi EndOfBuffer  guibg=NONE
--             hi SignColumn   guibg=NONE
--             hi VertSplit    guibg=NONE
--             hi CursorLine   guibg=NONE
--             hi StatusLineNC guibg=NONE
--             hi LspInlayHint guibg=NONE
--             hi LspInlayHint ctermfg=239 guifg=#5a524c
--
--             hi TelescopeBorder guibg=NONE
--         ]])
--
--         -- vim.api.nvim_set_hl(0, "CursorLine", { bg = "#1a1a1a" })
--     end,
--     group = general,
--     desc = 'Hide background and other elements'
-- })
