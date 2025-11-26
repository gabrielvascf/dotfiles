-- NvChad's 'defaults()' function has already run at this point,
-- setting up the base config, including NvChad's on_attach for UI.
-- This file now only needs to ADD servers and custom logic.

-- 1. DEFINE DEPENDENCIES AND SERVERS
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local servers = { "clangd", "pyright", "texlab", "prismals", "html", "ts_ls", "intelephense" }

--
-- 2. MERGE CAPABILITIES
--
-- We add cmp_nvim_lsp's capabilities to the global defaults.
-- This will be deep-merged with NvChad's defaults, not replace them.
vim.lsp.config('*', {
  capabilities = capabilities,
  --
  -- We DO NOT set on_attach here, as it would
  -- overwrite NvChad's UI-related on_attach function.
  --
})

--
-- 3. ADD CUSTOM LOGIC VIA LspAttach AUTOCOMMAND
--
-- This is the correct, non-conflicting way to add your custom logic.
-- It runs IN ADDITION to NvChad's on_attach, not instead of it.
local userLspGroup = vim.api.nvim_create_augroup('UserLspCustom', { clear = true })
vim.api.nvim_create_autocmd('LspAttach', {
  group = userLspGroup,
  desc = "User LSP: Set custom attach logic",
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf

    -- Enable LSP-based indentation (your custom logic)
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Enable formatting capabilities (your custom logic)
    -- We add a guard to be safe
    if client and client.supports_method('textDocument/formatting') then
      client.server_capabilities.documentFormattingProvider = true
    end
  end
})

--
-- 4. ENABLE SERVERS (THE NEW WAY)
--
-- This single call replaces the entire `for` loop.
-- Neovim will now automatically:
-- 1. Use the global defaults (NvChad's + our merged capabilities).
-- 2. Find the server-specific configs from nvim-lspconfig.
-- 3. Merge them and set up the server to start on the correct filetype.
vim.lsp.enable(servers)

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
