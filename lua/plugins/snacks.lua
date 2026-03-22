return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          layout = {
            layout = {
              width = 27,
              min_width = 27,
            },
          },
          win = {
            list = {
              keys = {
                ["n"] = { "yank_filename", desc = "Copy filename" },
              },
            },
          },
          actions = {
            yank_filename = function(_, item)
              if item then
                local name = vim.fn.fnamemodify(item.file, ":t")
                vim.fn.setreg("+", name)
                Snacks.notify("Copied: " .. name)
              end
            end,
          },
        },
      },
    },
  },
}
