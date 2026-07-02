local colors = require("colors")

hl.config({
    general = {
        gaps_in = 2,
        gaps_out = 6,

        border_size = 2,

        col = {
            active_border = {
                colors = { colors.primary, colors.on_primary, colors.primary },
                angle = 45
            },
            inactive_border = {
                colors = { colors.outline }
            },
        },

        layout = "dwindle",
    },

    decoration = {
        -- screen_shader = "./shaders/reading-mode.glsl",

        rounding = 12,
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
