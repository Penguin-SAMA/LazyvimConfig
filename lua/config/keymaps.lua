-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Cache cwd for each terminal to ensure consistent terminal ID
local term_cwd_cache = {}

local function get_cached_cwd(count)
  if not term_cwd_cache[count] then
    term_cwd_cache[count] = LazyVim.root()
  end
  return term_cwd_cache[count]
end

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimKeymaps",
  callback = function()
    -- Ctrl+/ : Horizontal terminal (bottom)
    vim.keymap.set({ "n", "t" }, "<c-/>", function()
      Snacks.terminal.toggle(nil, { count = 1, cwd = get_cached_cwd(1), win = { position = "bottom" } })
    end, { desc = "Toggle Horizontal Terminal" })

    -- Ctrl+\ : Vertical terminal (right)
    vim.keymap.set({ "n", "t" }, "<c-\\>", function()
      Snacks.terminal.toggle(nil, { count = 2, cwd = get_cached_cwd(2), win = { position = "right" } })
    end, { desc = "Toggle Vertical Terminal" })

    -- Ctrl+g : Floating terminal
    vim.keymap.set({ "n", "t" }, "<c-g>", function()
      Snacks.terminal.toggle(nil, { count = 3, cwd = get_cached_cwd(3), win = { position = "float" } })
    end, { desc = "Toggle Floating Terminal" })
  end,
})
