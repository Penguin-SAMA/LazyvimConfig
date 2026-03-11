return {
  -- DB/SQL 套件（不依赖 cmp）
  { "tpope/vim-dadbod", ft = { "sql", "mysql", "plsql" } },
  {
    "kristijanhusak/vim-dadbod-ui",
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    dependencies = { "tpope/vim-dadbod" },
  },
  {
    "kristijanhusak/vim-dadbod-completion",
    ft = { "sql", "mysql", "plsql" },
    dependencies = { "tpope/vim-dadbod" },
  },

  -- 让 blink.cmp 使用 Dadbod 的 provider（完全绕开 cmp）
  {
    "saghen/blink.cmp",
    optional = false,
    dependencies = { "kristijanhusak/vim-dadbod-completion" },
    opts = {
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "dadbod" },
        providers = {
          dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
        },
      },
    },
  },
}
