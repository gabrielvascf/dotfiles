require "nvchad.options"

local options = {
  tabstop = 2, -- Number of spaces for a tab
  shiftwidth = 2, -- Number of spaces for indentation
  expandtab = true, -- Use tabs instead of spaces
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
-- add yours here!
vim.g.conform_debug = true
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_view_forward_search_on_start = 1
vim.o.cursorlineopt = 'both' -- to enable cursorline!
-- local o = vim.o
