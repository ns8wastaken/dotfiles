local home = os.getenv("HOME")
local jdtls_path = home .. "/.local/share/jdtls/bin/jdtls"
local workspace_path = home .. "/.local/share/nvim/jdtls-workspace/"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = workspace_path .. project_name

-- See `:help vim.lsp.start_client` for an overview of the supported keys.
local config = {
    cmd = {
        jdtls_path,
        "-data", workspace_dir
    },

    root_dir = vim.fs.dirname(vim.fs.find(
        {'.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'},
        { upward = true }
    )[1]),

    -- Here you can configure various jdtls settings
    settings = {
        java = {
            -- Add any specific java configurations here if needed
        }
    },

    -- Language server capabilities
    init_options = {
        bundles = {}
    },
}

require('jdtls').start_or_attach(config)




local home = os.getenv("HOME")
local jdtls = require("jdtls")

-- 1. Identify the project root directory
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", ".project" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == nil then
    root_dir = vim.fn.getcwd()
end

-- 2. Unique workspace folder per project to prevent cache corruption
local workspace_folder = home .. "/.cache/jdtls/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

-- 3. Point to your local JDTLS installation path
local jdtls_base = home .. "/.local/share/jdtls"
local jdtls_bin = jdtls_base .. "/bin/jdtls"
-- Usually configuration data goes to a share or config directory inside the installation folder
local jdtls_config_dir = jdtls_base .. "/config" 

-- 4. Debugging Bundles (Optional - Only if you have vscode-java-debug installed)
local bundles = {}
-- If you use Mason or a local clone for java-debug, point to its server jar:
-- local debug_jar = vim.fn.glob(home .. "/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar")
-- if debug_jar ~= "" then table.insert(bundles, debug_jar) end

-- 5. On Attach keymaps and settings
local java_on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "<leader>jo", "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts)
    vim.keymap.set("n", "<leader>jrv", "<Cmd>lua require'jdtls'.extract_variable()<CR>", opts)
    vim.keymap.set("x", "<leader>jrv", "<Esc><Cmd>lua require'jdtls'.extract_variable(true)<CR>", opts)
    vim.keymap.set("n", "<leader>jrc", "<Cmd>lua require'jdtls'.extract_constant()<CR>", opts)
    vim.keymap.set("x", "<leader>jrc", "<Esc><Cmd>lua require'jdtls'.extract_constant(true)<CR>", opts)
    vim.keymap.set("x", "<leader>jrm", "<Esc><Cmd>lua require'jdtls'.extract_method(true)<CR>", opts)

  -- Enable codelens
    vim.lsp.codelens.enable(true, { bufnr = bufnr })
end

-- 6. Core JDTLS Configuration
local config = {
  cmd = {
    jdtls_bin,
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-data", workspace_folder,
  },
  root_dir = root_dir,
  on_attach = java_on_attach,
  flags = {
    allow_incremental_sync = true,
  },
}

-- 7. Java settings, runtimes, and completion targets
config.settings = {
  java = {
    referencesCodeLens = { enabled = true },
    signatureHelp = { enabled = true },
    implementationsCodeLens = { enabled = true },
    contentProvider = { preferred = 'fernflower' },

    completion = {
        favoriteStaticMembers = {
            "org.hamcrest.MatcherAssert.assertThat",
            "org.hamcrest.Matchers.*",
            "org.hamcrest.CoreMatchers.*",
            "org.junit.jupiter.api.Assertions.*",
            "java.util.Objects.requireNonNull",
            "java.util.Objects.requireNonNullElse",
            "org.mockito.Mockito.*"
        }
    },

    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    --
    -- Configure your runtimes using actual JDK paths on your system
    configuration = {
      runtimes = {
        {
          name = "JavaSE-17",
          path = "/usr/lib/jvm/java-17-openjdk/", -- Adjust to your local Java 17 path
        }
      }
    }
  }
}

config.on_init = function(client, _)
    client.notify('workspace/didChangeConfiguration', { settings = config.settings })
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
config.init_options = {
    bundles = bundles,
    extendedClientCapabilities = extendedClientCapabilities,
}

jdtls.start_or_attach(config)
-- If using DAP/Debugging, uncomment below:
-- jdtls.setup_dap({ hotcodereplace = "auto" })
