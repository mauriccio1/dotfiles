-- ~/.config/nvim/lua/config/lsp.lua

-- Setup Mason (LSP installer)
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "pyright",        -- Python
    "lua_ls",         -- Lua
    "bashls",         -- Bash
    "terraformls",    -- Terraform
    "yamlls",         -- YAML
    "jsonls",         -- JSON
    "marksman",       -- Markdown
  },
})

-- LSP keymaps (applied when LSP attaches)
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

-- Capabilities for autocompletion
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Python
vim.lsp.config.pyright = {
  default_config = {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "basic",
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
        },
      },
    },
  },
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Lua
vim.lsp.config.lua_ls = {
  default_config = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
      },
    },
  },
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Bash
vim.lsp.config.bashls = {
  default_config = {
    cmd = { "bash-language-server", "start" },
    filetypes = { "sh", "bash" },
  },
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Terraform
vim.lsp.config.terraformls = {
  default_config = {
    cmd = { "terraform-ls", "serve" },
    filetypes = { "terraform", "tf", "hcl" },
  },
  on_attach = on_attach,
  capabilities = capabilities,
}

-- YAML
vim.lsp.config.yamlls = {
  default_config = {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml", "yml" },
  },
  on_attach = on_attach,
  capabilities = capabilities,
}

-- JSON
vim.lsp.config.jsonls = {
  default_config = {
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "jsonc" },
  },
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Markdown
vim.lsp.config.marksman = {
  default_config = {
    cmd = { "marksman", "server" },
    filetypes = { "markdown", "md" },
  },
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Enable language servers
vim.lsp.enable("pyright")
vim.lsp.enable("lua_ls")
vim.lsp.enable("bashls")
vim.lsp.enable("terraformls")
vim.lsp.enable("yamlls")
vim.lsp.enable("jsonls")
vim.lsp.enable("marksman")

-- Diagnostic configuration
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})
