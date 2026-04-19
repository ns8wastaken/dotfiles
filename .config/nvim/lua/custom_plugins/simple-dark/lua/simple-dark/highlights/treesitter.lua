---@param c SimpleDarkPalette
---@return table<string, string>
return function(c) return {
    -- Keywords
    ["@keyword"]             = { link = "Keyword" },
    ["@keyword.function"]    = { link = "@keyword" },
    ["@keyword.operator"]    = { link = "@keyword" },
    ["@keyword.return"]      = { link = "@keyword" },
    ["@keyword.import"]      = { link = "@keyword" },
    ["@keyword.conditional"] = { link = "@keyword" },
    ["@keyword.repeat"]      = { link = "@keyword" },
    ["@keyword.exception"]   = { link = "@keyword" },
    ["@keyword.modifier"]    = { link = "@keyword" },
    ["@keyword.coroutine"]   = { link = "@keyword" },
    ["@label"]               = { link = "@keyword" },

    -- Types
    ["@type"]            = { link = "Type" },
    ["@type.builtin"]    = { link = "@type" },
    ["@type.qualifier"]  = { link = "@type" },
    ["@type.definition"] = { link = "@type" },

    -- Strings
    ["@string"]         = { link = "String" },
    ["@string.escape"]  = { fg = c.fg },
    ["@string.special"] = { fg = c.fg },
    ["@string.regexp"]  = { fg = c.fg },
    ["@character"]      = { link = "@string" },

    -- Numbers & boolean
    ["@number"]       = { link = "Number" },
    ["@number.float"] = { link = "Number" },
    ["@boolean"]      = { link = "Boolean" },

    -- Everything else
    ["@comment"]     = { fg = c.fg_dim },
    ["@operator"]    = { fg = c.fg },
    ["@namespace"]   = { fg = c.fg },
    ["@module"]      = { fg = c.fg },
    ["@attribute"]   = { fg = c.fg },
    ["@constructor"] = { fg = c.fg },
    ["@property"]    = { fg = c.fg },
    ["@field"]       = { fg = c.fg },

    -- Constants
    ["@constant"]         = { fg = c.fg },
    ["@constant.builtin"] = { link = "@constant" },
    ["@constant.macro"]   = { link = "@constant" },

    -- Variables
    ["@variable"]           = { fg = c.fg },
    ["@variable.builtin"]   = { link = "@variable" },
    ["@variable.member"]    = { link = "@variable" },
    ["@variable.parameter"] = { link = "@variable" },

    -- Punctuation
    ["@punctuation"]           = { fg = c.fg },
    ["@punctuation.bracket"]   = { link = "@punctuation" },
    ["@punctuation.delimiter"] = { link = "@punctuation" },
    ["@punctuation.special"]   = { link = "@punctuation" },

    -- Functions
    ["@function"]             = { fg = c.fg },
    ["@function.builtin"]     = { link = "@function" },
    ["@function.call"]        = { link = "@function" },
    ["@function.method"]      = { link = "@function" },
    ["@function.method.call"] = { link = "@function" },

    -- Tags (HTML/JSX)
    ["@tag"]           = { link = "@type" },
    ["@tag.attribute"] = { link = "@tag" },
    ["@tag.delimiter"] = { fg = c.fg_dim },

    -- Markup (markdown)
    ["@markup.heading"]       = { fg = c.fg,     bold = true },
    ["@markup.bold"]          = { fg = c.fg,     bold = true },
    ["@markup.italic"]        = { fg = c.fg,     italic = true },
    ["@markup.underline"]     = { fg = c.fg,     underline = true },
    ["@markup.strikethrough"] = { fg = c.fg_dim, strikethrough = true },
    ["@markup.link"]          = { fg = c.fg,     underline = true },
    ["@markup.link.url"]      = { fg = c.fg_dim, underline = true },
    ["@markup.raw"]           = { fg = c.fg_dim },
    ["@markup.list"]          = { fg = c.keyword },

    -- CSS selectors
    ["@type.css"]           = { link = "@type" },
    ["@property.class.css"] = { link = "@type.css" },
    ["@property.id.css"]    = { link = "@type.css" },
} end
