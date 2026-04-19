---@param c SimpleDarkPalette
---@return table<string, string>
return function(c) return {
    -- Core
    Normal      = { fg = c.fg,     bg = c.bg },
    NormalFloat = { fg = c.fg,     bg = c.bg },
    NormalNC    = { fg = c.fg,     bg = c.bg },
    FloatBorder = { fg = c.fg_dim, bg = c.bg },

    -- Cursor & selection
    Cursor       = { fg = c.bg, bg = c.fg },
    CursorLine   = { bg = "#262626" },
    CursorColumn = { bg = "#262626" },
    Visual       = { bg = "#333333" },
    VisualNOS    = { bg = "#333333" },

    -- Search
    Search    = { fg = c.fg, bg = "#444444" },
    IncSearch = { fg = c.bg, bg = c.keyword },
    CurSearch = { fg = c.bg, bg = c.keyword },

    -- Status & tabs
    StatusLine   = { fg = c.fg,     bg = c.bg },
    StatusLineNC = { fg = c.fg_dim, bg = "#2a2a2a" },
    TabLine      = { fg = c.fg_dim, bg = c.bg },
    TabLineSel   = { fg = c.bg,     bg = c.fg },
    TabLineFill  = { fg = c.fg,     bg = c.bg },

    -- Window chrome
    WinSeparator = { fg = "#444444" },
    VertSplit    = { fg = "#444444" },
    WildMenu     = { fg = c.bg, bg = c.fg },

    -- Gutter
    LineNr       = { fg = c.fg_dim },
    CursorLineNr = { fg = c.fg },
    SignColumn   = { bg = c.bg },
    FoldColumn   = { fg = c.fg_dim, bg = c.bg },
    Folded       = { fg = c.fg_dim, bg = "#2a2a2a" },

    -- Popup menu
    Pmenu      = { fg = c.fg, bg = "#2a2a2a" },
    PmenuSel   = { fg = c.bg, bg = c.fg },
    PmenuSbar  = { bg = "#333333" },
    PmenuThumb = { bg = c.fg },

    -- Misc
    NonText     = { fg = "#444444" },
    EndOfBuffer = { fg = c.bg },
    MatchParen  = { fg = c.keyword, bold = true },
    Conceal     = { fg = c.fg_dim },
    SpecialKey  = { fg = c.fg_dim },
    Title       = { fg = c.fg, bold = true },
    Directory   = { fg = c.fg },

    -- Diff
    -- DiffAdd    = { bg = "#1e3a1e" },
    -- DiffChange = { bg = "#2a2a1e" },
    -- DiffDelete = { bg = "#3a1e1e" },
    -- DiffText   = { bg = "#3a3a1e" },
    -- Added      = { fg = c.variable },
    -- Changed    = { fg = c.keyword },
    -- Removed    = { fg = c.error },
} end
