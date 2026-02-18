local map = vim.keymap.set

map('n', "]t", require("todo-comments").jump_next, { desc = "Next todo comment" })
map('n', "[t", require("todo-comments").jump_prev, { desc = "Previous todo comment" })
