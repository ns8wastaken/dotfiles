local map = function(mode, bind, func)
    vim.keymap.set(mode, bind, func, { noremap = true, silent = true })
end

-- Save file
map('n', "<Leader>w", "<Cmd>w<CR>")

-- Copy / paste
map('v', "<C-c>", '"+y')
map('i', "<C-v>", '<Esc>"+pa')
map('n', "<C-v>", '<Esc>"+pa')

-- Exit insert mode
map('i', "jk", "<Esc>")
map('i', "Jk", "<Esc>")
map('i', "jK", "<Esc>")
map('i', "JK", "<Esc>")

-- Put the rest of the line on a new line
map('n', "<A-o>", "mzi<CR><Esc>`z")

-- Lsp stuff
map('n', "gd",        vim.lsp.buf.definition)
map('n', "gD",        vim.lsp.buf.declaration)
map('n', "<C-k>",     vim.lsp.buf.signature_help)
map('n', "<Leader>e", vim.diagnostic.open_float)

-- Lsp goto errors
map('n', "]g", function() vim.diagnostic.jump({ count=1, float=true }) end)
map('n', "[g", function() vim.diagnostic.jump({ count=-1, float=true }) end)

map('n', "]e", function()
    vim.diagnostic.jump({ count=1, float=true, severity=vim.diagnostic.severity.ERROR })
end)

map('n', "[e", function()
    vim.diagnostic.jump({ count=-1, float=true, severity=vim.diagnostic.severity.ERROR })
end)

map('n', "<Leader>r", vim.lsp.buf.rename)
