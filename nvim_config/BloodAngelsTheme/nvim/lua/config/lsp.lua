-- ═══════════════════════════════════════════════════════════════
-- BLOOD ANGELS LSP CONFIGURATION - HIGH CONTRAST
-- Clear, Readable Diagnostics with Blood Angels Flavor
-- ═══════════════════════════════════════════════════════════════
-- ~/.config/nvim/lua/config/lsp.lua

-- ═══════════════════════════════════════════════════════════════
-- Setup Mason
-- ═══════════════════════════════════════════════════════════════
local ok_mason, mason = pcall(require, "mason")
if not ok_mason then return end

local ok_mason_lsp, mason_lsp = pcall(require, "mason-lspconfig")
if not ok_mason_lsp then return end

mason.setup({
    ui = {
        border = "rounded",
        icons = {
            package_installed = "⚔️",
            package_pending = "⏳",
            package_uninstalled = "✗"
        }
    }
})

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
        "html",
        "htmx",
        "cssls",
    }
})

-- ═══════════════════════════════════════════════════════════════
-- Common on_attach and capabilities
-- ═══════════════════════════════════════════════════════════════
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

-- ═══════════════════════════════════════════════════════════════
-- Helper to register servers
-- ═══════════════════════════════════════════════════════════════
local function register_lsp(name, config)
    config = vim.tbl_deep_extend("force", {
        on_attach = on_attach,
        capabilities = capabilities,
    }, config or {})

    local lsp_config = {
        default_config = config
    }
    
    -- Explicitly set filetypes at the top level if provided
    if config.filetypes then
        lsp_config.filetypes = config.filetypes
    end
    
    -- Set root_markers for root detection if root_dir function is provided
    if config.root_dir then
        lsp_config.root_markers = config.root_markers or {}
    end

    vim.lsp.config[name] = vim.tbl_deep_extend("force", vim.lsp.config[name] or {}, lsp_config)
end

-- ═══════════════════════════════════════════════════════════════
-- Register language servers
-- ═══════════════════════════════════════════════════════════════

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
    filetypes = { "terraform", "tf", "hcl" },
    root_dir = function(fname)
        -- Find .terraform or .git directory
        local util = vim.fs
        local root = util.root(0, {".terraform", ".git"})
        if root then
            return root
        end
        -- Fallback: use the directory of the current file
        return vim.fn.fnamemodify(fname, ":h")
    end,
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

-- HTML
register_lsp("html", {
    cmd = { "vscode-html-language-server", "--stdio" },
    filetypes = { "html", "templ" }
})

-- HTMX
register_lsp("htmx", {
    cmd = { "htmx-lsp" },
    filetypes = { "html", "templ" }
})

-- ═══════════════════════════════════════════════════════════════
-- Diagnostics config - HIGH CONTRAST & CLEAR
-- ═══════════════════════════════════════════════════════════════

-- Blood Angels diagnostic signs
local signs = {
    { name = "DiagnosticSignError", text = "⚠️" },
    { name = "DiagnosticSignWarn",  text = "⚡" },
    { name = "DiagnosticSignHint",  text = "💡" },
    { name = "DiagnosticSignInfo",  text = "ℹ️" },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

-- Diagnostic configuration - CLEAR ERROR MESSAGES
vim.diagnostic.config({
    virtual_text = {
        prefix = "●",
        spacing = 4,
        -- Show actual error message clearly
        format = function(diagnostic)
            return diagnostic.message
        end,
    },
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
        border = "rounded",
        source = "always",
        header = "🩸 Sanguinary Priest Report",
        prefix = function(diagnostic, i, total)
            local icons = {
                [vim.diagnostic.severity.ERROR] = "⚠️ ERROR",
                [vim.diagnostic.severity.WARN] = "⚡ WARN",
                [vim.diagnostic.severity.INFO] = "ℹ️ INFO",
                [vim.diagnostic.severity.HINT] = "💡 HINT",
            }
            local icon = icons[diagnostic.severity] or "•"
            return string.format("%s [%d/%d]: ", icon, i, total)
        end,
        suffix = function(diagnostic)
            -- Show source if available
            if diagnostic.source then
                return string.format(" (%s)", diagnostic.source)
            end
            return ""
        end,
        format = function(diagnostic)
            -- Return the actual diagnostic message, clean and clear
            return diagnostic.message
        end,
        focusable = true,
        focus = false,
        -- High contrast colors
        style = "minimal",
        max_width = 80,
        max_height = 20,
    }
})

-- Custom handlers with high contrast
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
    title = "📖 Documentation",
    max_width = 80,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
    title = "⚔️ Signature",
    max_width = 80,
})

-- ═══════════════════════════════════════════════════════════════
-- Custom commands
-- ═══════════════════════════════════════════════════════════════

vim.api.nvim_create_user_command("LspRestart", function()
    vim.cmd("LspRestart")
    vim.notify("⚔️ LSP restarted", vim.log.levels.INFO)
end, {})

vim.api.nvim_create_user_command("LspStatus", function()
    vim.cmd("LspInfo")
end, {})

vim.api.nvim_create_user_command("Format", function()
    vim.lsp.buf.format({ async = true })
    vim.notify("🩸 Code formatted", vim.log.levels.INFO)
end, {})

-- ═══════════════════════════════════════════════════════════════
-- Enhance diagnostic display
-- ═══════════════════════════════════════════════════════════════
-- Show line diagnostics automatically in hover window



print("🩸 LSP Configuration Loaded - For Sanguinius!")
