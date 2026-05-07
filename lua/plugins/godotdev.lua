return {
  "Mathijs-Bakker/godotdev.nvim",
  dependencies = { "nvim-dap", "nvim-dap-ui", "nvim-treesitter" },
  config = function()
    require("godotdev").setup({
      -- Optional configuration options
      -- (e.g., disable setup for plugins you don't have)
    })
  end,
}
