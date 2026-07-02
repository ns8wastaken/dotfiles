local commands = {
    "QS_DISABLE_HOT_RELOAD=1 quickshell -d",
    "copyq",
    "awww-daemon",
}

hl.on("hyprland.start", function()
    for _, cmd in ipairs(commands) do
        hl.exec_cmd(cmd)
    end
end)
