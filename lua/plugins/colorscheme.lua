return {
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     -- colorscheme = "catppuccin-mocha",
  --     -- colorscheme = "nord",
  --     -- colorscheme = "tokyonight",
  --     -- colorscheme = "everforest",
  --   },
  -- },
  -- {
  --   "catppuccin",
  --   opts = {
  --     transparent_background = true,
  --     float = {
  --       transparent = true,
  --       -- solid = true,
  --     },
  --     auto_integrations = true,
  --   },
  -- },
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {
  --     style = "moon", -- 可选：night, storm, moon, day
  --     transparent = true,
  --   },
  -- },
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    -- Optional; default configuration will be used if setup isn't called.
    config = function()
      require("everforest").setup({
        -- Your config here
        transparent_background_level = 2,
        background = "hard",
        italics = true,
        ui_contrast = "high",
      })

      vim.cmd("colorscheme everforest")
    end,
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
