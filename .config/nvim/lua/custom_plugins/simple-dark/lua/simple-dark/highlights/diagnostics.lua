---@param c SimpleDarkPalette
---@return table<string, string>
return function(c) return {
    DiagnosticError = { fg = c.error },
    DiagnosticWarn  = { fg = c.warn },
    DiagnosticHint  = { fg = c.info },
    DiagnosticInfo  = { fg = c.hint },

                            -- { underline  = true }  -- straight line
                            -- { undercurl  = true }  -- wavy (most common for errors)
                            -- { underdouble = true } -- double straight line
                            -- { underdotted = true } -- dotted
                            -- { underdashed = true } -- dashed
    DiagnosticUnderlineError = { underline = true, sp = c.error },
    DiagnosticUnderlineWarn  = { underline = true, sp = c.warn },
    DiagnosticUnderlineHint  = { underline = true, sp = c.info },
    DiagnosticUnderlineInfo  = { underline = true, sp = c.hint },
} end
