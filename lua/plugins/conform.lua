return {
  {
    "stevearc/conform.nvim",
    opts = function()
      ---@class ConformOpts
      return {
        -- LazyVim will use these options when formatting with the conform.nvim formatter
        default_format_opts = {
          lsp_format = "fallback",
        },
        formatters_by_ft = {
          lua = { "stylua" },
          fish = { "fish_indent" },
          sh = { "shfmt" },
          python = { "isort", "black" },
          c = { "clang_format" },
          cpp = { "clang_format" },
          rust = { "rustfmt" },
          h = { "clang_format" },
        },
        -- LazyVim will merge the options you set here with builtin formatters.
        -- You can also define any custom formatters here.
        ---@type table<string,table>
        formatters = {
          injected = { options = { ignore_errors = true } },
          clang_format = {
            prepend_args = function()
              return { "--style=file:" .. vim.fn.expand("~/.clang-format") }
            end,
          },
        },
      }
    end,
  },
}
