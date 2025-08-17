-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>fT", function()
  Snacks.terminal(nil, { win = { position = "right" } })
end, { desc = "Terminal right" })

vim.keymap.set("n", "<C-/>", function()
  Snacks.terminal(nil, { cwd = LazyVim.root(), win = { position = "float", border = "rounded" } })
end, { desc = "Terminal float root" })
