return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rust_analyzer = {
          mason = false,
        },
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "off", -- 关闭严格类型检查
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
              },
            },
          },
          before_init = function(params)
            -- 自动使用项目中的 .venv
            local venv = vim.fn.getcwd() .. "/.venv/bin/python"
            if vim.fn.executable(venv) == 1 then
              params["config"] = params["config"] or {}
              params["config"].settings = params["config"].settings or {}
              params["config"].settings.python = params["config"].settings.python or {}
              params["config"].settings.python.pythonPath = venv
            end
          end,
        },
      },
    },
  },
}
