local map = function(mode, bind, func)
    vim.keymap.set(mode, bind, func, { noremap = true, silent = true })
end

local telescope = require("telescope");
map('n', "<Leader>fb", function()
    telescope.extensions.file_browser.file_browser({
        grouped = true,
        hidden = true
    })
end)

local telescope_builtin = require("telescope.builtin")
map('n', "<Leader>ff", function()
    telescope_builtin.find_files({
        find_command = {
            "fd",
            "--type", "f",
            "--no-require-git"
        }
    })
end)
map('n', "<leader>fg", telescope_builtin.live_grep)
map('n', "<Leader>km", telescope_builtin.keymaps)
map('n', "<Leader>cs", telescope_builtin.colorscheme)
