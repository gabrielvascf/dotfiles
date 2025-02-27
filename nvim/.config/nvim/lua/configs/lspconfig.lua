-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()
require("java").setup()

local lspconfig = require "lspconfig"
-- EXAMPLE
local servers = { "clangd", "ts_ls", "emmet_language_server", "pylyzer", "texlab", "jdtls" }
local nvlsp = require "nvchad.configs.lspconfig"
local capabilities = require("cmp_nvim_lsp").default_capabilities()
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
