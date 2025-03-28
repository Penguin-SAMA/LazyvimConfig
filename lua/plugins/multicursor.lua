return {
  "mg979/vim-visual-multi",
  branch = "master",
  init = function()
    vim.g.VM_default_mappings = 0
    vim.g.VM_mouse_mappings = 1
    vim.g.VM_maps = {
      ["Find Under"] = "<C-n>",
      ["Skip Region"] = "<C-x>",
      ["Remove Region"] = "<C-p>",

      -- 禁用可能冲突的窗口快捷键
      ["Add Cursor Up"] = "<M-up>", -- 修改为 Alt+k
      ["Add Cursor Down"] = "<M-down>", -- 修改为 Alt-j
      ["Add Cursor"] = "<C-LeftMouse>",
    }
  end,
  lazy = false,
}
