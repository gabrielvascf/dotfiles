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
      conf.suggestion = { enabled = false }
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
    "zbirenbaum/copilot-cmp",
    lazy = false,
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, conf)
      table.insert(conf.sources, { name = "copilot" })
    end,
  },
  {
    "lervag/vimtex",
    lazy = false,
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
