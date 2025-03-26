local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    javascript = { "prettier" },
    json = { "prettier" },
    markdown = { "prettier" },
    typescriptreact = { "prettier" },
    typescript = { "prettier" },
    tex = { "latexindent" },
  },
  log_level = vim.log.levels.DEBUG,
  log_path = "~/.local/state/nvim/conform.log",
}

return options
