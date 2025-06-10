local lspconfig = require('lspconfig')
local cmp_lsp = require('cmp_nvim_lsp')
local capabilities = cmp_lsp.default_capabilities()

local enable_inlayhints = function() vim.lsp.inlay_hint.enable(true, { 0 }) end -- Function to enable inlay hints on current buffer

-- Python
lspconfig.pyright.setup({ capabilities = capabilities })

-- Rust
lspconfig.rust_analyzer.setup({
    cmd = { 'rustup', 'run', 'stable', 'rust-analyzer' },
    capabilities = capabilities,
    on_attach = enable_inlayhints
})

-- Typescript
lspconfig.ts_ls.setup({ capabilities = capabilities })

-- HTML
lspconfig.html.setup({
    capabilities = capabilities
})

-- CSS
local cssls_caps = vim.lsp.protocol.make_client_capabilities()
cssls_caps.textDocument.completion.completionItem.snippetSupport = true -- Needed otherwise autocomplete wont work
lspconfig.cssls.setup({ capabilities = cssls_caps })

-- Clangd
lspconfig.clangd.setup({ capabilities = capabilities })

-- Lua
lspconfig.lua_ls.setup({
    capabilities = capabilities,

    settings = {
        Lua = {
            -- runtime = {
            --     -- Tell the LSP you're using LuaJIT (Neovim uses this)
            --     version = 'LuaJIT'
            -- },
            diagnostics = {
                -- Recognize the `vim` global
                globals = { 'vim' }
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false -- Optional: avoid prompt to configure third-party
            },
            telemetry = {
                enable = false,
            }
        }
    }
})
