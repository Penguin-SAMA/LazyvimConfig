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
          -- ["_"] = { "clang_format" }, -- if not, clang_format not work for .h file
        },
        -- LazyVim will merge the options you set here with builtin formatters.
        -- You can also define any custom formatters here.
        ---@type table<string,table>
        formatters = {
          injected = { options = { ignore_errors = true } },
          -- # Example of using dprint only when a dprint.json file is present
          -- dprint = {
          --   condition = function(ctx)
          --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
          --   end,
          -- },
          --
          -- # Example of using shfmt with extra args
          -- shfmt = {
          --   extra_args = { "-i", "2", "-ci" },
          -- },
          clang_format = { prepend_args = { "--style=file:C:/Users/PenguinSAMA/.clang-format" } },
          rust = { "rustfmt", lsp_format = "fallback" },
        },
      }
    end,
  },
}
