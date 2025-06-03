-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()
-- require("java").setup()

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"
local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- EXAMPLE
local servers = { "clangd", "pyright", "texlab", "luau_lsp", "prismals", "html", "ts_ls", "intelephense" }
-- lsps with default config
local on_attach = function(client, bufnr)
  -- Enable LSP-based indentation
  vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
  client.server_capabilities.documentFormattingProvider = true
end
lspconfig.util.default_config.on_attach = on_attach
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = capabilities,
  }
end

-- typescript setup
-- require("typescript-tools").setup {
--   on_attach = on_attach,
-- }

-- tsgo
-- if not configs.typescript_go then
--   configs.typescript_go = {
--     default_config = {
--       -- point this at your locally‑built tsgo binary + "lsp"
--       cmd       = { "/home/gabriel/Documents/GitHub/typescript-go/built/local/tsgo", "lsp", "-stdio" },
--       filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
--       root_dir  = util.root_pattern("tsconfig.json", "package.json", ".git"),
--       settings  = {},
--     },
--     docs = {
--       description = [[
--         Native‑Go port of the TS compiler with LSP support.
--       ]],
--     },
--   }
-- end
--
-- -- 3) Finally, start it just like any other LSP:
-- lspconfig.typescript_go.setup {
--   on_attach    = nvlsp.on_attach,
--   on_init      = nvlsp.on_init,
--   capabilities = capabilities,
-- }
