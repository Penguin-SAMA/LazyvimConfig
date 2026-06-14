local function is_unreal_project_file(filename)
  if not filename or filename == "" then
    return false
  end

  local dirname = vim.fs.dirname(filename)
  if not dirname or dirname == "" then
    return false
  end

  return vim.fs.find(function(name)
    return name:match("%.uproject$") ~= nil or name:match("%.uplugin$") ~= nil
  end, { path = dirname, upward = true })[1] ~= nil
end

local function get_diagnostic_line(uri, diagnostic)
  if not (uri and diagnostic and diagnostic.range and diagnostic.range.start) then
    return ""
  end

  local bufnr = vim.uri_to_bufnr(uri)
  if not vim.api.nvim_buf_is_loaded(bufnr) then
    return ""
  end

  local line = diagnostic.range.start.line
  return vim.api.nvim_buf_get_lines(bufnr, line, line + 1, false)[1] or ""
end

local function is_unreal_clangd_false_positive(diagnostic, line)
  local source = diagnostic.source or ""
  if source ~= "" and source ~= "clang" and source ~= "clangd" then
    return false
  end

  local message = diagnostic.message or ""
  local code = tostring(diagnostic.code or "")
  local is_generated_macro = message:find("FID_", 1, true)
    and (message:find("_PROLOG", 1, true) or message:find("_GENERATED_BODY", 1, true))

  if is_generated_macro then
    return true
  end

  if line:find("UCLASS", 1, true) or line:find("GENERATED_BODY", 1, true) then
    if code == "unknown_typename" or code == "missing_type_specifier" then
      return true
    end

    if message:find("A type specifier is required", 1, true) then
      return true
    end
  end

  if message:find("Call to deleted constructor of 'UAttributeSet'", 1, true) then
    return true
  end

  if line:find("ATTRIBUTE_ACCESSORS", 1, true) then
    if message:find("Cannot initialize object parameter of type 'const UAttributeSet'", 1, true) then
      return true
    end

    if message:find("Member access into incomplete type 'UAbilitySystemComponent'", 1, true) then
      return true
    end
  end

  return false
end

local function handle_clangd_diagnostics(err, result, ctx, config)
  if result and result.uri and result.diagnostics and is_unreal_project_file(vim.uri_to_fname(result.uri)) then
    result = vim.deepcopy(result)
    result.diagnostics = vim.tbl_filter(function(diagnostic)
      return not is_unreal_clangd_false_positive(diagnostic, get_diagnostic_line(result.uri, diagnostic))
    end, result.diagnostics)
  end

  return vim.lsp.handlers["textDocument/publishDiagnostics"](err, result, ctx, config)
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          mason = false,
          root_markers = {
            "compile_commands.json",
            "compile_flags.txt",
            ".clangd",
            ".uproject",
            ".uplugin",
            "configure.ac",
            "Makefile",
            "configure.in",
            "config.h.in",
            "meson.build",
            "meson_options.txt",
            "build.ninja",
            ".git",
          },
          capabilities = {
            offsetEncoding = { "utf-16" },
          },
          cmd = {
            "C:/Program Files/Microsoft Visual Studio/18/Community/VC/Tools/Llvm/x64/bin/clangd.exe",
            "--background-index",
            "--header-insertion=never",
            "--completion-style=detailed",
            "--function-arg-placeholders=true",
            "--fallback-style=llvm",
            "--query-driver=C:/Program Files/Microsoft Visual Studio/18/Community/VC/Tools/Llvm/x64/bin/clang-cl.exe",
          },
          handlers = {
            ["textDocument/publishDiagnostics"] = handle_clangd_diagnostics,
          },
        },
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
