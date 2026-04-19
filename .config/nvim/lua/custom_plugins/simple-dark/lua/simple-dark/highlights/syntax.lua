---@param c SimpleDarkPalette
---@return table<string, string>
return function(c) return {
    -- Keywords
    Keyword     = { fg = c.keyword, bold = true },
    Statement   = { link = "Keyword" },
    PreProc     = { link = "Keyword" },
    Define      = { link = "Keyword" },
    Include     = { link = "Keyword" },
    Conditional = { link = "Keyword" },
    Repeat      = { link = "Keyword" },
    Label       = { link = "Keyword" },
    Exception   = { link = "Keyword" },

    -- Identifiers
    Identifier = { fg = c.type },
    Function   = { fg = c.type }, -- Used in some random places that treesitter doesnt define

    -- Numbers & boolean
    Number  = { fg = c.fg },
    Float   = { link = "Number" },
    Boolean = { fg = c.boolean },

    -- Other
    Comment      = { fg = c.fg_dim },
    Constant     = { fg = c.fg },
    String       = { fg = c.fg },
    Character    = { fg = c.fg },
    Type         = { fg = c.type },
    StorageClass = { fg = c.fg },
    Structure    = { fg = c.fg },
    Typedef      = { fg = c.fg },
    Special      = { fg = c.fg },
    SpecialChar  = { fg = c.fg },
    Delimiter    = { fg = c.fg },
    Operator     = { fg = c.fg },
    Underlined   = { fg = c.fg, underline = true },
    Error        = { fg = c.error },
    Todo         = { fg = c.keyword, bold = true },
} end
