-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()
require("java").setup()

local lspconfig = require "lspconfig"
-- EXAMPLE
local servers = { "clangd", "ts_ls", "emmet_language_server", "pylyzer", "texlab", "jdtls" }
local nvlsp = require "nvchad.configs.lspconfig"
local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = capabilities,
  }
end
-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
