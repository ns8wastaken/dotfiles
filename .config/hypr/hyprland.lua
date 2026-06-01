require("binds")
require("animations.fast")


----------------
--- Monitors ---
----------------

hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@144",
    position = "auto",
    scale    = "auto"
})


-----------------
--- Autostart ---
-----------------

hl.on("hyprland.start", function()
    hl.exec_cmd("QS_DISABLE_HOT_RELOAD=1 quickshell -d")
    hl.exec_cmd("copyq")
    hl.exec_cmd("awww-daemon")
end)


-----------------------------
--- Environment Variables ---
-----------------------------

hl.env("XDG_DESKTOP_PORTAL_HYPRLAND_FORCE_SHM", "1")

hl.env("XCURSOR_THEME",    "Bibata-Modern-Classic")
hl.env("XCURSOR_SIZE",     "24")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("HYPRCURSOR_SIZE",  "24")

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE",    "wayland")

hl.env("QT_AUTO_SCREEN_SCALE_FACTOR",         "1")
hl.env("QT_QPA_PLATFORM",                     "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME",                "qt5ct")


---------------------
--- Look and Feel ---
---------------------

hl.config({
    general = {
        gaps_in = 2,
        gaps_out = 4,

        border_size = 1,

        -- col = {
        --     active_border = $primary $on_primary 45deg,
        --     inactive_border = $outline,
        -- },

        layout = "dwindle",
    },

    decoration = {
        -- screen_shader = ~/.config/hypr/shaders/cinema.glsl,

        rounding = 8,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity = 1.0,
        inactive_opacity = 0.95,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },

        blur = {
            enabled = true,
            size = 4,
            passes = 3,
            vibrancy = 1,
            noise = 0.075,
            -- vibrancy = 0.169,
        },
    },
})

hl.config({
    master = {
        new_status = "master",
    }
})


-- Layout configs
hl.config({
    dwindle = {
        preserve_split = true,
    },

    scrolling = {
        fullscreen_on_one_column = true,
    }
})


-------------
--- Input ---
-------------

hl.config({
    input = {
        kb_layout    = "us",
        kb_variant   = "",
        kb_model     = "",
        kb_options   = "",
        kb_rules     = "",
        repeat_rate  = 40,
        repeat_delay = 300,

        numlock_by_default = true,

        follow_mouse = 1,

        touchpad = {
            natural_scroll = true,
            scroll_factor = 0.75,
        },

        accel_profile = "adaptive",
        sensitivity = -1.0,

        -- scroll_method = on_button_down
        -- scroll_button = 274
        -- scroll_button_lock = 0
    }
})


hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})


------------------------------
--- Windows and Workspaces ---
------------------------------

hl.window_rule({
    name = "windowrule-1",
    match = {
        class = "com.github.hluk.copyq",
    },
    float = true,
})

-- Ignore maximize requests from apps. You'll probably like this.
hl.window_rule({
    name = "windowrule-2",
    match = {
        class = ".*",
    },
    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name = "windowrule-3",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = 1,
        float      = 1,
        fullscreen = 0,
        pin        = 0,
    },
    no_focus = true,
})

hl.window_rule({
    name = "windowrule-4",
    match = {
        class         = "(nemo)",
        initial_title = "^(.*)Properties$",
    },
    float = true,
})

hl.window_rule({
    name = "windowrule-5",
    match = {
        class = "(cmake-gui)",
    },
    float = true,
})
