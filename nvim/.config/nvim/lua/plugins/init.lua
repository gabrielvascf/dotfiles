return {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
    lazy = false,
  },
  -- These are some examples, uncomment them if you want to see them work!
  {
    "zbirenbaum/copilot.lua",
    lazy = false,
    opts = function(_, conf)
      conf.suggestion = {
        enabled = true,
        auto_trigger = true,
        h1_group = "Comment",
        keymap = {
          accept = "<M-l>",
          dismiss = "<M-h>",
          trigger = "<C-space>",
        },
      }
      conf.panel = { enabled = false }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "hrsh7th/nvim-cmp",
  },
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_syntax_conceal_enabled = 1
      vim.g.vimtex_syntax_conceal = {
        accents = 1,
        ligatures = 1,
        cites = 1,
        greek = 1,
        math_bounds = 1,
        math_delimiters = 1,
      }
      vim.opt.conceallevel = 2
      vim.g.vimtex_compiler_output_path = "."
      vim.g.vimtex_compiler_latexmk = {
        build_dir = "build",
        aux_dir = "./build/aux",
        log_dir = "./build/logs",
      }
    end,
  },
  {
    "nvim-java/nvim-java",
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      git = {
        ignore = false, -- Show gitignored files
      },
      on_attach = function(bufnr)
        local api = require "nvim-tree.api"

        local function opts(desc)
          return {
            desc = "nvim-tree: " .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true,
          }
        end
        api.config.mappings.default_on_attach(bufnr)
        vim.keymap.set("n", "C", api.tree.change_root_to_node, opts "Change Root to Node")
      end,
    },
  },
}
