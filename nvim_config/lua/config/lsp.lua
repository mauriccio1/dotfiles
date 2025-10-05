-- ~/.config/nvim/lua/config/lsp.lua

-- ===============================
-- Setup Mason (LSP installer)
-- ===============================
local ok_mason, mason = pcall(require, "mason")
if not ok_mason then return end

local ok_mason_lsp, mason_lsp = pcall(require, "mason-lspconfig")
if not ok_mason_lsp then return end

mason.setup()
mason_lsp.setup({
    ensure_installed = {
        "pyright",
        "lua_ls",
        "bashls",
        "terraformls",
        "yamlls",
        "jsonls",
        "marksman",
        "gopls",
        "clangd",
        "powershell_es",
    }
})

-- ===============================
-- Common on_attach and capabilities
-- ===============================
local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- ===============================
-- Helper to register servers
-- ===============================
local function register_lsp(name, config)
    config = vim.tbl_deep_extend("force", {
        on_attach = on_attach,
        capabilities = capabilities,
    }, config or {})

    vim.lsp.config[name] = vim.tbl_deep_extend("force", vim.lsp.config[name] or {}, {
        default_config = config
    })
end

-- ===============================
-- Register language servers
-- ===============================

-- Python
register_lsp("pyright", {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
            }
        }
    }
})

-- Lua
register_lsp("lua_ls", {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
            telemetry = { enable = false },
        }
    }
})

-- Bash
register_lsp("bashls", {
    cmd = { "bash-language-server", "start" },
    filetypes = { "sh", "bash" }
})

-- Go
register_lsp("gopls", {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    settings = {
        gopls = {
            analyses = { unusedparams = true, shadow = true },
            staticcheck = true,
            gofumpt = true,
        }
    }
})

-- C/C++
register_lsp("clangd", {
    cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    capabilities = vim.tbl_deep_extend("force", capabilities, { offsetEncoding = { "utf-16" } }),
})

-- Terraform
register_lsp("terraformls", {
    cmd = { "terraform-ls", "serve" },
    filetypes = { "terraform", "tf", "hcl" }
})

-- YAML
register_lsp("yamlls", {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml", "yml" }
})

-- JSON
register_lsp("jsonls", {
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "jsonc" }
})

-- Markdown
register_lsp("marksman", {
    cmd = { "marksman", "server" },
    filetypes = { "markdown", "md" }
})

-- PowerShell
local mason_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services"
local pwsh_script = mason_path .. "/PowerShellEditorServices/Start-EditorServices.ps1"

register_lsp("powershell_es", {
    cmd = {
        "pwsh",
        "-NoLogo",
        "-NoProfile",
        "-Command",
        string.format(
            [[& '%s' -BundledModulesPath '%s/PowerShellEditorServices' -LogPath '%s/powershell_es.log' -SessionDetailsPath '%s/powershell_es_session.json' -FeatureFlags @() -AdditionalModules @() -HostName 'nvim' -HostProfileId 'nvim' -HostVersion '1.0.0' -LogLevel 'Normal']],
            pwsh_script,
            mason_path,
            vim.fn.stdpath("cache"),
            vim.fn.stdpath("cache")
        )
    },
    filetypes = { "ps1", "psm1", "psd1" }
})

-- ===============================
-- Diagnostics config
-- ===============================
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = { border = "rounded", source = "always" }
})

