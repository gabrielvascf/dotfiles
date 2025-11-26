require "configs.tabsettings"
vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "
vim.o.winborder = 'rounded'
vim.opt.relativenumber = true
vim.api.nvim_set_hl(0, "Comment", { fg = "#808080" }) -- Ensure comments are grey
vim.opt.clipboard:append { "unnamedplus" } -- Use system clipboard
-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

-- Replace the old is_rojo_project() block in your init.lua with this
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.luau",
  callback = function()
    -- Check for a rojo project file in parent directories
    local is_rojo = vim.fs.find({ "default.project.json", "rojo.json" }, { upward = true, stop = vim.env.HOME })[1]
    if is_rojo then
      vim.bo.filetype = "luau"
    end
  end,
})
