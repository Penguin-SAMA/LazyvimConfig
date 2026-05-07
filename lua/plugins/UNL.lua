return {
  {
    "taku25/UnrealDev.nvim",
    -- Define all plugins in the development suite.
    -- You can remove any plugins you don't use.
    dependencies = {
      {
        "taku25/UNL.nvim", -- Core Library
        build = "cargo build --release --manifest-path scanner/Cargo.toml",
        lazy = false,
      },
      "taku25/UEP.nvim", -- Project Explorer
      "taku25/UEA.nvim", -- Asset (Blueprint) Inspector
      "taku25/UBT.nvim", -- Build Tool
      "taku25/UCM.nvim", -- Class Manager
      "taku25/ULG.nvim", -- Log Viewer
      "taku25/USH.nvim", -- Unreal Shell
      {
        "taku25/UNX.nvim", -- Logical View
        dependencies = {
          "MunifTanjim/nui.nvim",
          "nvim-tree/nvim-web-devicons",
        },
      },
      "taku25/UDB.nvim", -- Debug
      {
        "taku25/USX.nvim", -- Syntax highlight
        lazy = false,
      },

      -- UI Plugins (Optional)
      "nvim-telescope/telescope.nvim",
      "j-hui/fidget.nvim",
      "nvim-lualine/lualine.nvim",
      {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        config = function(_, opts)
          vim.api.nvim_create_autocmd("User", {
            pattern = "TSUpdate",
            callback = function()
              local parsers = require("nvim-treesitter.parsers")
              parsers.cpp = {
                install_info = {
                  url = "https://github.com/taku25/tree-sitter-unreal-cpp",
                  -- Check if need to update to the latest revision
                  revision = "7bbb85f1fcc6e109c90cea2167e88a5a472910d3",
                },
              }
              parsers.ushader = {
                install_info = {
                  url = "https://github.com/taku25/tree-sitter-unreal-shader",
                  -- Check if need to update to the latest revision
                  revision = "26f0617475bb5d5accb4d55bd4cc5facbca81bbd",
                },
              }
            end,
          })
          local langs = { "c", "cpp", "ushader", "json" }
          require("nvim-treesitter").install(langs)
          local group = vim.api.nvim_create_augroup("MyTreesitter", { clear = true })
          vim.api.nvim_create_autocmd("FileType", {
            group = group,
            pattern = langs,
            callback = function(args)
              vim.treesitter.start(args.buf)
              vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
          })
        end,
      },
      -- ...
    },
    opts = {
      -- Configuration specific to UnrealDev.nvim
      -- (e.g., disable setup for plugins you don't have)
      setup_modules = {
        UBT = true,
        UEP = true,
        ULG = true,
        USH = true,
        UCM = true,
        UEA = true,
        UNX = true,
      },
    },
    config = function(_, opts)
      require("UnrealDev").setup(opts)

      local group = vim.api.nvim_create_augroup("UnrealDevAutoCwd", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufReadPost" }, {
        group = group,
        pattern = { "*.uproject", "*.cpp", "*.h", "*.hpp", "*.cs" },
        callback = function(args)
          if vim.bo[args.buf].buftype ~= "" then
            return
          end

          local ok, project = pcall(require, "UNL.finder.project")
          if not ok then
            return
          end

          local file = vim.api.nvim_buf_get_name(args.buf)
          local project_root = project.find_project_root(file ~= "" and file or vim.loop.cwd())
          if project_root and project_root ~= vim.loop.cwd() then
            vim.api.nvim_set_current_dir(project_root)
          end
        end,
      })
    end,
  },

  -- ---
  -- Individual Plugin Settings (Optional)
  -- ---
  --{ 'taku25/UBT.nvim', opts = { ... } },
  --{ 'taku25/UEP.nvim', opts = { ... } },
  --{ 'taku25/UEA.nvim', opts = { ... } },
  -- ...
}
