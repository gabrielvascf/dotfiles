local config = require("nvchad.configs.nvimtree").setup

config({
  filters = {
    dotfiles = false,
    git_ignored = false
  }
})
