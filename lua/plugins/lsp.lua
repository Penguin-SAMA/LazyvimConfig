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
  {
    "mrcjkb/rustaceanvim",
    optional = true, -- 若你没装这个插件也不会报错
    init = function()
      local cfg = vim.g.rustaceanvim or {}
      cfg.server = cfg.server or {}
      cfg.server.default_settings = cfg.server.default_settings or {}
      cfg.server.default_settings["rust-analyzer"] = cfg.server.default_settings["rust-analyzer"] or {}
      cfg.server.default_settings["rust-analyzer"].files = cfg.server.default_settings["rust-analyzer"].files or {}

      -- 仅此一行：把文件监控改为服务端，更稳地捕捉新增模块/文件
      cfg.server.default_settings["rust-analyzer"].files.watcher = "server"

      vim.g.rustaceanvim = cfg
    end,
  },
}
