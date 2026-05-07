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

-- Open the include file under the cursor (Enhances standard 'gf')
vim.keymap.set("n", "<leader>gf", require("UEP.api").open_file, { noremap = true, silent = true })

-- Jump to actual definition, even for Forward Declarations
vim.keymap.set("n", "gd", require("UEP.api").goto_definition, { noremap = true, silent = true })

-- Toggle between Header and Source files (<leader>a : Alternate)
vim.keymap.set("n", "<leader>a", function()
  require("UnrealDev.api").switch_file()
end, { noremap = true, silent = true })

-- <C-s>: Automatically branches between Live Coding (if Editor is running) and UBT Build (if stopped)
vim.keymap.set("n", "<C-s>", function()
  require("UnrealDev.api").is_process_running({
    process_name = "UnrealEditor",
    on_complete = function(is_running)
      if is_running == false then
        -- Editor is NOT running -> Execute normal Build
        print("🚀 Starting UBT Build...")
        require("UnrealDev.api").build({})
      else
        -- Editor IS running -> Trigger Live Coding
        print("🔥 Triggering Live Coding...")
        require("UnrealDev.api").remote_command("livecoding.compile")
      end
    end,
  })
end, { noremap = true, silent = true })
