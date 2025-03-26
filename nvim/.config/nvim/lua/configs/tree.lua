local config = require("nvchad.configs.nvimtree").setup

config {
  side = "right",
  filters = {
    dotfiles = false,
    git_ignored = false,
  },
}
