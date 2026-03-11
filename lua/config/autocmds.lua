-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*", -- 所有文件类型，可按需替换为具体类型（如 "python"）
  callback = function()
    -- 禁用自动插入注释标记
    vim.bo.formatoptions = vim.bo.formatoptions:gsub("[ro]", "")
    vim.opt_local.spell = false
  end,
})

-- rust中禁用'自动补全
-- 建议把 augroup 提前创建并复用
-- ~/.config/nvim/lua/config/autocmds.lua
local rust_grp = vim.api.nvim_create_augroup("Rust_disable_single_quote", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  group = rust_grp,
  desc = "Disable single quote autopair in Rust (mini.pairs)",
  callback = function(args)
    local ok, mp = pcall(require, "mini.pairs")
    if not ok then
      return
    end
    -- 注意这里把第四个参数 "''" 加回来了
    if type(mp.unmap_buf) == "function" then
      mp.unmap_buf(args.buf, "i", "'", "''")
    elseif type(mp.unmap) == "function" then
      mp.unmap("i", "'", "''")
    end
  end,
})
