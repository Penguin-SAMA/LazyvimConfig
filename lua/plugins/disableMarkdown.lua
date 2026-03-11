return {
  {
    "jay-babu/mason-null-ls.nvim",
    opts = {
      automatic_installation = true, -- 或者 false，看你原本的配置
      handlers = {
        -- 对于 markdownlint，直接传入一个空函数以“覆盖”默认行为，等效于禁用
        markdownlint = function() end,
      },
    },
  },
}
