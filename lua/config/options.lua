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

-- 禁用不需要的 provider，消除 checkhealth 警告
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
