return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    local nls = require("null-ls")

    -- 1) 去掉 clang-format 和 fish 相关 source（Windows 下不需要）
    opts.sources = vim.tbl_filter(function(source)
      return source.name ~= "clang_format"
        and source.name ~= "fish_indent"
        and source.name ~= "fish"
    end, opts.sources or {})

    -- 2) 显式禁用 C/C++（保持你原来的逻辑）
    nls.disable({ filetypes = { "c", "cpp", "h" } })

    -- 3) 追加 sqlfluff，并指定方言（按需改成 mysql / bigquery / snowflake …）
    vim.list_extend(opts.sources or {}, {
      nls.builtins.diagnostics.sqlfluff.with({
        extra_args = { "--dialect", "postgres" }, -- 这里改成你实际用的
      }),
      -- 如果想同时启用格式化，可再打开：
      -- nls.builtins.formatting.sqlfluff.with({
      --   extra_args = { "--dialect", "postgres", "fix" },
      -- }),
    })
  end,
}
