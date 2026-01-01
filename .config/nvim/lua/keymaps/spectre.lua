local map_set = vim.keymap.set

map_set('n', "<Leader>S", require("spectre").toggle, { desc = "Toggle Spectre" })

map_set('n', "<Leader>sw", function()
    require("spectre").open_visual({
        select_word = true
    })
end, { desc = "Search current word" })

map_set('n', "<Leader>sw", require("spectre").open_visual, { desc = "Search current word" })

map_set('n', "<Leader>sp", function()
    require("spectre").open_visual({
        select_word = true
    })
end, { desc = "Search on current file" })
