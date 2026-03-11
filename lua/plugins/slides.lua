return {
  {
    "aspeddro/slides.nvim",
    cmd = "Slides", -- 只有执行 :Slides 时才加载
    opts = {
      -- 这个插件 README 里示例是 setup{}，你可以把配置写进 opts
      -- fullscreen = true, -- 如果你想默认全屏（插件仓库提到过 fullscreen 选项）
    },
    config = function(_, opts)
      require("slides").setup(opts or {})
    end,
    keys = {
      {
        "<leader>S",
        "<cmd>Slides<cr>",
        desc = "Slides: start presentation",
      },
    },
  },
}
