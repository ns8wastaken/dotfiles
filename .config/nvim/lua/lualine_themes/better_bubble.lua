local colors = {
    transparent = "#000000",
    blue   = "#80a0ff",
    cyan   = "#79dac8",
    black  = "#080808",
    yellow = "#eedd00",
    white  = "#c6c6c6",
    red    = "#ff5189",
    violet = "#d183e8",
    gray   = "#303030",
}

local theme = {
    normal = {
        a = { fg = colors.white, bg = colors.transparent },
        b = { fg = colors.white, bg = colors.transparent },
        c = { fg = colors.white, bg = colors.transparent }
    },

    -- insert = { a = { fg = colors.black, bg = colors.blue } },
    -- visual = { a = { fg = colors.black, bg = colors.cyan } },
    -- replace = { a = { fg = colors.black, bg = colors.red } },

    inactive = { c = { fg = colors.white, bg = colors.transparent } }
}

M = {
    options = {
        theme = theme,
        component_separators = "",
        section_separators = ""
    },
    sections = {
        -- These are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- These will be filled later
        lualine_c = {},
        lualine_x = {}
    },
    inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {}
    },
    tabline = {},
    extensions = {}
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
    table.insert(M.sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right section
local function ins_right(component)
    table.insert(M.sections.lualine_x, component)
end

-- Inserts a component in lualine_c at left section
local function ins_left_in(component)
    table.insert(M.inactive_sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right section
local function ins_right_in(component)
    table.insert(M.inactive_sections.lualine_x, component)
end

ins_left {
    "mode",
    separator = { left = '', right = '' },
    color = { fg = colors.black, bg = colors.violet }
}

ins_left("branch")

ins_left {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = { error = ' ', warn = ' ', info = ' ' },
    separator = { left = '', right = '' },
    diagnostics_color = {
        error = { fg = colors.red },
        warn = { fg = colors.yellow },
        info = { fg = colors.cyan }
    },
    color = { bg = colors.gray }
}

-- Center the following elements
ins_left { "%=" }

ins_left {
    "filename",

    file_status = true, -- Displays file status (readonly status, modified status)
    separator = { left = '', right = '' },
    color = { bg = colors.gray },
    newfile_status = true, -- Display new file status (new file means no write after created)

    path = 1, -- 0: Just the filename
    -- 1: Relative path
    -- 2: Absolute path
    -- 3: Absolute path, with tilde as the home directory
    -- 4: Filename and parent dir, with tilde as the home directory

    shorting_target = 0, -- Shortens path to leave 40 spaces in the window for other components. (terrible name, any suggestions?)

    symbols = {
        modified = "[+]", -- Text to show when the file is modified.
        readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
        unnamed = "[No Name]", -- Text to show for unnamed buffers.
        newfile = "[New]" -- Text to show for newly created file before first write
    }
}

ins_right("filetype")

ins_right {
    "%p%%/%L:%c",
    separator = { left = '', right = '' },
    color = { bg = colors.gray }
}

ins_left_in {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = { error = ' ', warn = ' ', info = ' ' },
    separator = { left = '', right = '' },
    diagnostics_color = {
        error = { fg = colors.red },
        warn = { fg = colors.yellow },
        info = { fg = colors.cyan },
    },
    color = { bg = colors.gray }
}

-- Center the following elements
ins_left_in { "%=" }

ins_left_in {
    "filename",
    separator = { left = '', right = '' },
    color = { bg = colors.gray }
}

ins_right_in("filetype")

return M
