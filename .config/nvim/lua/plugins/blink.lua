return {
    "saghen/blink.cmp",

    -- dependencies = { 'rafamadriz/friendly-snippets' },

    version = "1.*", -- downloads prebuilt binaries
    -- build = "cargo build --release",

    opts = {
        fuzzy = {
            sorts = {
                "exact",
                -- defaults
                "score",
                "sort_text"
            }
        },

        snippets = { preset = "luasnip" },

        sources = {
            default = { "lsp", "path", "snippets", "buffer" }
        }
    }
}
