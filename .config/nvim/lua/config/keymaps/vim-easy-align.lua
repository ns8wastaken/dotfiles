local map = function(mode, bind, func)
    vim.keymap.set(mode, bind, func, { noremap = true, silent = true })
end

map('x', "<Leader>a", "<Plug>(EasyAlign)")
map('n', "<Leader>a", "<Plug>(EasyAlign)")
