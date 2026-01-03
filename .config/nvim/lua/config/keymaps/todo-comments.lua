local map_set = vim.keymap.set

map_set('n', "]t", require("todo-comments").jump_next, { desc = "Next todo comment" })
map_set('n', "[t", require("todo-comments").jump_prev, { desc = "Previous todo comment" })
