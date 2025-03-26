-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()
require("java").setup()

local lspconfig = require "lspconfig"
-- EXAMPLE
local servers = { "clangd", "emmet_ls", "pylyzer", "texlab", "jdtls", "luau_lsp" }
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

-- typescript setup
require("typescript-tools").setup {
  on_attach = on_attach,
}
