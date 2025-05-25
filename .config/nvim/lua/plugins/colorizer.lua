return {
    'catgoose/nvim-colorizer.lua',

    opts = {
        filetypes = {
            "*",
            css = {
                css    = true;
                css_fn = true;
                names = true,
                names_opts = {
                    lowercase    = true,      -- name:lower(), highlight `blue` and `red`
                    camelcase    = true,      -- name, highlight `Blue` and `Red`
                    uppercase    = false,     -- name:upper(), highlight `BLUE` and `RED`
                    strip_digits = false      -- ignore names with digits,
                    -- highlight `blue` and `red`, but not `blue3` and `red4`
                }
            }
        },

        user_default_options = {
            names = false,                -- "Name" codes like Blue or red.  Added from `vim.api.nvim_get_color_map()`
            names_custom = false,         -- Custom names to be highlighted: table|function|false
            RGB          = true,          -- #RGB hex codes
            RGBA         = true,          -- #RGBA hex codes
            RRGGBB       = true,          -- #RRGGBB hex codes
            RRGGBBAA     = true,          -- #RRGGBBAA hex codes
            AARRGGBB     = false,         -- 0xAARRGGBB hex codes
            rgb_fn       = true,          -- CSS rgb() and rgba() functions
            hsl_fn       = true,          -- CSS hsl() and hsla() functions
            css          = false,         -- Enable all CSS *features*:
            css_fn       = false,         -- Enable all CSS *functions*: rgb_fn, hsl_fn
            tailwind     = false,         -- Tailwind colors.  boolean|'normal'|'lsp'|'both'.  True sets to 'normal'
            tailwind_opts = {
                update_names = false      -- When using tailwind = 'both', update tailwind names from LSP results.  See tailwind section
            },

            mode = "background", -- Highlighting mode.  'background'|'foreground'|'virtualtext'

            -- Virtualtext character to use
            virtualtext = "■",
            -- Display virtualtext inline with color.  boolean|'before'|'after'.  True sets to 'after'
            virtualtext_inline = false,
            -- Virtualtext highlight mode: 'background'|'foreground'
            virtualtext_mode = "foreground"
        }
    }
}
