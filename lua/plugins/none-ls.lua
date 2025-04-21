return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    local nls = require("null-ls")

    -- 移除C/C++的格式化工具，避免与conform.nvim冲突
    opts.sources = vim.tbl_filter(function(source)
      return not (source.name == "clang_format")
    end, opts.sources or {})

    -- 如果你根本不想用null-ls对C/C++，可以显式禁用
    nls.disable({ filetypes = { "c", "cpp", "h" } })
  end,
}
