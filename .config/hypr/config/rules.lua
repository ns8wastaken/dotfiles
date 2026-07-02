local window_rules = {
    {
        name = "copyq",
        match = {
            class = "com.github.hluk.copyq",
        },
        float = true,
    },
    {
        name = "suppress-maximize",
        match = {
            class = ".*",
        },
        suppress_event = "maximize",
    },
    {
        name = "xwayland-drag-fix",
        match = {
            class      = "^$",
            title      = "^$",
            xwayland   = 1,
            float      = 1,
            fullscreen = 0,
            pin        = 0,
        },
        no_focus = true,
    },
    {
        name = "nemo-properties",
        match = {
            class         = "(nemo)",
            initial_title = "^(.*)Properties$",
        },
        float = true,
    },
    {
        name = "cmake-gui",
        match = {
            class = "(cmake-gui)",
        },
        float = true,
    },
}

for _, rule in ipairs(window_rules) do
    hl.window_rule(rule)
end

local layer_rules = {
    {
        name = "shellous-slide",
        match = {
            namespace = "^shellous:(launcher|wallpaperSwitcher)$",
        },
        animation = "slide",
    },
}

for _, rule in ipairs(layer_rules) do
    hl.layer_rule(rule)
end
