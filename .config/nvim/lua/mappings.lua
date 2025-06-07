local map_set = vim.keymap.set

-- Copy / paste
map_set('v', '<C-c>', '"+y',       vim.g.keymap_opts)
map_set('i', '<C-v>', '<Esc>"+pa', vim.g.keymap_opts)
map_set('n', '<C-v>', '<Esc>"+pa', vim.g.keymap_opts)

-- Exit insert mode
map_set('i', 'jk', '<Esc>', vim.g.keymap_opts)

-- Put the rest of the line on a new line
map_set('n', '<A-o>', 'mzi<CR><Esc>`z', vim.g.keymap_opts)

-- Lsp stuff
map_set('n', 'gd',        vim.lsp.buf.definition,     vim.g.keymap_opts)
map_set('n', 'gD',        vim.lsp.buf.declaration,    vim.g.keymap_opts)
map_set('n', '<C-k>',     vim.lsp.buf.signature_help, vim.g.keymap_opts)
map_set('n', '<Leader>e', vim.diagnostic.open_float,  vim.g.keymap_opts)

-- Lsp goto errors
map_set('n', ']g', vim.diagnostic.goto_next, vim.g.keymap_opts)
map_set('n', '[g', vim.diagnostic.goto_prev, vim.g.keymap_opts)

map_set('n', ']e', function()
    vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end, vim.g.keymap_opts)

map_set('n', '[e', function()
    vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, vim.g.keymap_opts)

map_set("n", "<Leader>r", vim.lsp.buf.rename, vim.g.keymap_opts)
