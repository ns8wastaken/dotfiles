local terminal    = "kitty"
local termShell   = "fish"
local fileManager = "kitty yazi"
local calculator  = "speedcrunch"
local neovim      = "nvim"

local mainMod = "SUPER" -- Sets "Windows" key as main modifier


-- Keybind funcs
local nomod_bind = function(key, dispatcher, extra)
    hl.bind(key, dispatcher, extra)
end

local mod_bind = function(key, dispatcher, extra)
    hl.bind(mainMod .. " + " .. key, dispatcher, extra)
end

-- Dispatcher funcs
local exec   = function(cmd) return hl.dsp.exec_cmd(cmd) end
local global = function(cmd) return hl.dsp.global(cmd) end


-- Logout menu
mod_bind("R", global("quickshell:wlogout"))

-- Utilities
mod_bind("S",         exec("grimblast -n copy area"))
mod_bind("SHIFT + S", exec("grimblast save area ~/Pictures/Screenshots/screenshot.png"))
mod_bind("G",         exec("hyprpicker --autocopy"))
nomod_bind("F8",      exec("~/bin/autoclicker.sh"))

-- Software
mod_bind("N", exec(termShell .. " -c '" .. terminal .. " " .. neovim .. "'"))
mod_bind("C", exec(calculator))
mod_bind("V", exec("copyq toggle"))
mod_bind("H", global("quickshell:wallpaperPicker"))
mod_bind("D", exec("wayscriber --active"))

-- System
mod_bind("SHIFT + F", hl.dsp.window.fullscreen())
mod_bind("F",         hl.dsp.window.float())
-- mod_bind("J",         "togglesplit")
mod_bind("Q",         hl.dsp.window.close())
mod_bind("T",         exec(terminal))
mod_bind("E",         exec(termShell .. " -c '" .. fileManager .. "'"))
mod_bind("SPACE",     global("quickshell:launcher"))

-- Move focus with mainMod + arrow keys
mod_bind("left",  hl.dsp.focus({ direction = "left" }))
mod_bind("right", hl.dsp.focus({ direction = "right" }))
mod_bind("up",    hl.dsp.focus({ direction = "up" }))
mod_bind("down",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10
    mod_bind(key,               hl.dsp.focus({ workspace = i }))
    mod_bind("SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
mod_bind("X", hl.dsp.workspace.toggle_special("magic"))

-- Scroll through existing workspaces with mainMod + scroll
mod_bind("mouse_down", hl.dsp.focus({ workspace = "e+1" }))
mod_bind("mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
-- (Assuming your framework maps mouse binds like this using the same helper)
mod_bind("mouse:272", hl.dsp.window.drag(),   { mouse = true })
mod_bind("mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
nomod_bind("XF86AudioRaiseVolume",  exec("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
nomod_bind("XF86AudioLowerVolume",  exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
nomod_bind("XF86AudioMute",         exec("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
nomod_bind("XF86AudioMicMute",      exec("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
nomod_bind("XF86MonBrightnessUp",   exec("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
nomod_bind("XF86MonBrightnessDown", exec("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
nomod_bind("XF86AudioNext",  exec("playerctl next"),       { locked = true })
nomod_bind("XF86AudioPause", exec("playerctl play-pause"), { locked = true })
nomod_bind("XF86AudioPlay",  exec("playerctl play-pause"), { locked = true })
nomod_bind("XF86AudioPrev",  exec("playerctl previous"),   { locked = true })
