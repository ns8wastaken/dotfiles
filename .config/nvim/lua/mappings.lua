local map_set = vim.keymap.set
local keymap_opts = { noremap = true, silent = true }

-- Copy / paste
map_set('v', '<C-c>', '"+y',       keymap_opts)
map_set('i', '<C-v>', '<Esc>"+pa', keymap_opts)
map_set('n', '<C-v>', '<Esc>"+pa', keymap_opts)

-- Exit insert mode
map_set('i', 'jk', '<Esc>', keymap_opts)

-- Put the rest of the line on a new line
map_set('n', '<A-o>', 'mzi<CR><Esc>`z', keymap_opts)

-- Lsp stuff
map_set('n', 'gd',        vim.lsp.buf.definition,     keymap_opts)
map_set('n', 'gD',        vim.lsp.buf.declaration,    keymap_opts)
map_set('n', '<C-k>',     vim.lsp.buf.signature_help, keymap_opts)
map_set('n', '<Leader>e', vim.diagnostic.open_float,  keymap_opts)
