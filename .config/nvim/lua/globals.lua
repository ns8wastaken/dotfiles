-- Set OS
local sysname = vim.loop.os_uname().sysname
vim.g.is_windows = sysname == "Windows_NT"
vim.g.is_linux   = sysname == "Linux"
vim.g.is_mac     = sysname == "Darwin"

-- Set shell
vim.o.shell = (vim.g.is_windows and {'powershell -NoLogo'} or {'bash'})[1]
vim.o.guifont = "JetBrainsMonoNL Nerd Font Mono:h13"

-- Set the <Leader> char
vim.g.mapleader = ','

-- Gruvbox theme settings
vim.g.gruvbox_material_background = 'medium' -- soft, medium, hard
vim.g.gruvbox_material_foreground = 'medium' -- soft, medium, hard


-- Railgun particle effect on cursor jump
vim.g.neovide_cursor_vfx_mode = ''
vim.g.neovide_cursor_vfx_particle_density = 3.0
vim.g.neovide_cursor_vfx_particle_phase = 2.5
vim.g.neovide_cursor_vfx_opacity = 200.0
vim.g.neovide_cursor_animation_length = 0.075

if vim.g.is_linux then
    vim.g.neovide_opacity = 0.8
end
