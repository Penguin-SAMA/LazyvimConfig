return {
  {
    "stevearc/conform.nvim",
    opts = function()
      local vs_clang_format =
        "C:/Program Files/Microsoft Visual Studio/18/Community/VC/Tools/Llvm/x64/bin/clang-format.exe"

      local function is_unreal_project(ctx)
        local dirname = ctx and ctx.dirname or vim.fn.getcwd()
        return vim.fs.find(function(name)
          return name:match("%.uproject$") ~= nil
        end, { path = dirname, upward = true })[1] ~= nil
      end

      ---@class ConformOpts
      return {
        -- LazyVim will use these options when formatting with the conform.nvim formatter
        default_format_opts = {
          timeout_ms = 5000,
          lsp_format = "fallback",
        },
        formatters_by_ft = {
          lua = { "stylua" },
          fish = { "fish_indent" },
          sh = { "shfmt" },
          python = { "ruff_fix", "ruff_format" },
          c = { "clang-format" },
          cpp = { "clang-format" },
          rust = { "rustfmt" },
          h = { "clang-format" },
        },
        -- LazyVim will merge the options you set here with builtin formatters.
        -- You can also define any custom formatters here.
        ---@type table<string,table>
        formatters = {
          injected = { options = { ignore_errors = true } },
          ["clang-format"] = {
            command = function(_, ctx)
              if vim.uv.fs_stat(vs_clang_format) and is_unreal_project(ctx) then
                return vs_clang_format
              end

              return "clang-format"
            end,
            prepend_args = function()
              return { "--style=file:" .. vim.fn.expand("~/.clang-format") }
            end,
          },
        },
      }
    end,
  },
}
