-- Curves / Béziers
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1}, {0.32, 1} } })
hl.curve("easeOutCubic",   { type = "bezier", points = { {0.33, 1}, {0.68, 1} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0}, {0.35, 1} } })
hl.curve("linear",         { type = "bezier", points = { {0, 0}, {1, 1} } })

-- Animations
hl.animation({ leaf = "border",           enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",        enabled = true, speed = 3,    bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "windowsOut",       enabled = true, speed = 5,    bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "windowsMove",      enabled = true, speed = 2,    bezier = "easeOutQuint" })
hl.animation({ leaf = "fadeIn",           enabled = true, speed = 1.75, bezier = "linear" })
hl.animation({ leaf = "fadeOut",          enabled = true, speed = 1.5,  bezier = "linear" })
hl.animation({ leaf = "fade",             enabled = true, speed = 3,    bezier = "linear" })
hl.animation({ leaf = "layers",           enabled = true, speed = 3.81, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "fadeLayersIn",     enabled = true, speed = 1.79, bezier = "linear" })
hl.animation({ leaf = "fadeLayersOut",    enabled = true, speed = 1.39, bezier = "linear" })
hl.animation({ leaf = "workspaces",       enabled = true, speed = 3,    bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3,    bezier = "easeOutQuint", style = "slidevert" })

-- Commented out animations
hl.animation({ leaf = "workspacesIn",        enabled = true, speed = 2, bezier = "easeOutCubic", style = "slide" })
hl.animation({ leaf = "workspacesOut",       enabled = true, speed = 2, bezier = "easeOutCubic", style = "slide" })
-- hl.animation({ leaf = "specialWorkspaceIn",  enabled = true, speed = 3, bezier = "easeOutQuint", style = "slidevert" })
-- hl.animation({ leaf = "specialWorkspaceOut", enabled = true, speed = 3, bezier = "easeOutQuint", style = "slidevert" })
