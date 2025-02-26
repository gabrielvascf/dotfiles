require "nvchad.options"

local options = {
  tabstop = 4, -- Number of spaces for a tab
  shiftwidth = 4, -- Number of spaces for indentation
  expandtab = true, -- Use tabs instead of spaces
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
-- add yours here!
vim.g.conform_debug = true
-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
