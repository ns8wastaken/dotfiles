local env = {
    XDG_DESKTOP_PORTAL_HYPRLAND_FORCE_SHM = "1",

    XCURSOR_THEME    = "Bibata-Modern-Classic",
    XCURSOR_SIZE     = "24",
    HYPRCURSOR_THEME = "Bibata-Modern-Classic",
    HYPRCURSOR_SIZE  = "24",

    XDG_CURRENT_DESKTOP = "Hyprland",
    XDG_SESSION_DESKTOP = "Hyprland",
    XDG_SESSION_TYPE    = "wayland",

    QT_AUTO_SCREEN_SCALE_FACTOR         = "1",
    QT_QPA_PLATFORM                     = "wayland;xcb",
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1",
    QT_QPA_PLATFORMTHEME                = "qt5ct",
}

for key, value in pairs(env) do
    hl.env(key, value)
end
