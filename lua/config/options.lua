-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.g.lazyvim_rust_diagnostics = "rust-analyzer"
vim.opt.guifont = "Maple Mono NF CN"
vim.opt.spell = false
vim.opt.wrap = true
vim.opt.autoread = true

if vim.g.neovide then
  vim.g.neovide_corner_preference = "round"
  vim.g.neovide_opacity = 0.95
  vim.g.neovide_normal_opacity = 0.95
  vim.g.background = "#2B3339"
  vim.g.neovide_background_color = "#2B3339"
  vim.g.neovide_position_animation_length = 0.15
  vim.g.neovide_scroll_animation_length = 0.3
  vim.g.neovide_refresh_rate = 165
  vim.g.neovide_refresh_rate_idle = 5
  vim.g.neovide_cursor_animation_length = 1
  vim.g.neovide_cursor_short_animation_length = 0.04
  vim.g.neovide_cursor_trail_size = 5.0
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_animate_in_insert_mode = true
  vim.g.neovide_cursor_animate_command_line = true
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.g.neovide_cursor_vfx_opacity = 200.0
  vim.g.neovide_cursor_vfx_particle_lifetime = 2
  vim.g.neovide_cursor_vfx_particle_density = 10
  vim.g.neovide_cursor_vfx_particle_speed = 10.0
end

local godot_nvim_server = [[\\.\pipe\godot.nvim]]
if vim.fn.has("win32") == 1 and not vim.tbl_contains(vim.fn.serverlist(), godot_nvim_server) then
  pcall(vim.fn.serverstart, godot_nvim_server)
end
