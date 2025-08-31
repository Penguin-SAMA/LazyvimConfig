return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
      -- colorscheme = "nord",
      -- colorscheme = "tokyonight",
    },
  },
  {
    "catppuccin",
    opts = {
      transparent_background = true,
      float = {
        transparent = true,
        -- solid = true,
      },
      auto_integrations = true,
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "moon", -- 可选：night, storm, moon, day
      transparent = true,
    },
  },
  -- {
  --   "gbprod/nord.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {
  --     transparent = true, -- 开启透明背景
  --     styles = {
  --       comments = { italic = true },
  --       functions = { bold = true },
  --       keywords = { italic = true },
  --     },
  --   },
  --   config = function(_, opts)
  --     require("nord").setup(opts)
  --     vim.cmd.colorscheme("nord")
  --   end,
  -- },
  -- border highlight when background is transparent
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.window = {
        completion = {
          border = "rounded",
          winhighlight = "Normal:MyHighlight",
          winblend = 0,
        },
        documentation = {
          border = "rounded",
          winhighlight = "Normal:MyHighlight",
          winblend = 0,
        },
      }
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        float = {
          border = "rounded",
        },
      },
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        progress = {
          enabled = false,
        },
      },
      presets = {
        lsp_doc_border = true,
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    init = function()
      local bufline = require("catppuccin.groups.integrations.bufferline")
      function bufline.get()
        return bufline.get_theme()
      end
    end,
  },
}
