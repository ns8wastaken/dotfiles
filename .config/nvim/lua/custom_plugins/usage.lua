return {
    dir = vim.fn.stdpath("config") .. "/lua/custom_plugins/usage",

    opts = {
        mode = "float", -- "float" / "notify" / "print"
        timer_interval_s = 120
    }
}
