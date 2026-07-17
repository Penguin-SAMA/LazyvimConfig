return {
  "monkoose/neocodeium",
  event = "VeryLazy",
  opts = {
    -- blink.cmp 已负责自动补全；手动触发可避免两个补全 UI 互相遮挡。
    manual = true,
  },
  config = function(_, opts)
    local neocodeium = require("neocodeium")
    neocodeium.setup(opts)

    vim.keymap.set("i", "<A-e>", neocodeium.cycle_or_complete, { desc = "Trigger AI completion" })
    vim.keymap.set("i", "<A-f>", neocodeium.accept, { desc = "Accept AI completion" })
    vim.keymap.set("i", "<A-w>", neocodeium.accept_word, { desc = "Accept AI completion word" })
    vim.keymap.set("i", "<A-a>", neocodeium.accept_line, { desc = "Accept AI completion line" })
  end,
}
