-- local lspconfig = require('lspconfig')
local cmp_lsp = require("cmp_nvim_lsp")
local capabilities = cmp_lsp.default_capabilities()

local enable_inlayhints = function() vim.lsp.inlay_hint.enable(true, { 0 }) end -- Function to enable inlay hints on current buffer

-- Python
-- lspconfig.pyright.setup({ capabilities = capabilities })
vim.lsp.enable("pyright")
vim.lsp.config("pyright", { capabilities = capabilities })

-- Rust
vim.lsp.enable("rust_analyzer")
vim.lsp.config("rust_analyzer", {
    cmd = { "rustup", "run", "stable", "rust-analyzer" },
    capabilities = capabilities,
    on_attach = enable_inlayhints
})

-- Typescript
vim.lsp.enable("ts_ls")
vim.lsp.config("ts_ls", { capabilities = capabilities })

-- HTML
vim.lsp.enable("html")
vim.lsp.config("html", { capabilities = capabilities })

-- CSS
local cssls_caps = vim.lsp.protocol.make_client_capabilities()
cssls_caps.textDocument.completion.completionItem.snippetSupport = true -- Needed otherwise autocomplete wont work
vim.lsp.enable("cssls")
vim.lsp.config("cssls", { capabilities = cssls_caps })

-- Clangd
vim.lsp.enable("clangd")
vim.lsp.config("clangd", { capabilities = capabilities })

-- Lua
vim.lsp.enable("lua_ls")
vim.lsp.config("lua_ls", {
    capabilities = capabilities,

    settings = {
        Lua = {
            -- runtime = {
            --     version = 'LuaJIT' -- (Neovim uses this)
            -- },
            diagnostics = {
                -- Recognize the `vim` global
                globals = { "vim" }
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

-- Go
vim.lsp.enable("gopls")
vim.lsp.config("gopls", { capabilities = capabilities })

-- Assembly
vim.lsp.enable("asm_lsp")
vim.lsp.config("asm_lsp", { capabilities = capabilities })

-- GLSL
vim.lsp.enable("glsl_analyzer")
vim.lsp.config("glsl_analyzer", { capabilities = capabilities })

-- QML
vim.lsp.enable("qmlls")
