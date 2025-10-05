───────────────────────────────────────────────
N E O V I M   L S P   S E T U P   (as of 2025)
───────────────────────────────────────────────

Author: mauricciosantamaria
System: macOS (Ferrum-Dominus)
Neovim: v0.11.4
Mason: Installed and managing LSP binaries
───────────────────────────────────────────────

OVERVIEW
────────
This configuration provides full LSP support in Neovim using the new
`vim.lsp.config` API introduced in Neovim 0.11. This replaces the old
`require('lspconfig')` framework, which is now deprecated and will be
removed in future releases (v3.0.0+ of nvim-lspconfig).

The setup integrates:
  - Mason (LSP/DAP/Linter installer)
  - Mason-LSPConfig (automatic integration)
  - nvim-cmp (autocompletion)
  - cmp-nvim-lsp (capabilities for completion)
  - Lua keybindings and diagnostics configuration

───────────────────────────────────────────────
FILE STRUCTURE
──────────────
~/.config/nvim/
│
├── init.lua                  → Main entry point
│
└── lua/
    └── config/
        ├── lsp.lua           → All LSP configuration (this file)
        ├── mason.lua         → Mason setup (optional)
        └── keymaps.lua       → LSP-related keymaps

───────────────────────────────────────────────
THE PROBLEM
────────────
In late 2024 and 2025, Neovim’s LSP API changed significantly.

- The old method:
    require('lspconfig').pyright.setup({ ... })
  is now deprecated.

- The new method:
    vim.lsp.config.pyright = { default_config = {...} }
    vim.lsp.enable('pyright')

This new API avoids dependency on `nvim-lspconfig` entirely and allows
LSPs to be registered natively inside Neovim itself.

───────────────────────────────────────────────
POWERSHELL LSP
───────────────
The most troublesome LSP to configure was `powershell_es`, provided by
the `powershell-editor-services` package from Mason.

Key points:
  • Mason installs it to:
      ~/.local/share/nvim/mason/packages/powershell-editor-services/

  • The startup script is located at:
      PowerShellEditorServices/Start-EditorServices.ps1

  • The LSP is launched using `pwsh`:
      pwsh -NoLogo -NoProfile -Command "& '<path>/Start-EditorServices.ps1' ..."

If `pwsh` is not found (`brew install powershell`), Neovim throws
“cmd: expected table, got nil” errors.

───────────────────────────────────────────────
HOW LSPs ARE REGISTERED
────────────────────────
Each LSP is declared via:
  vim.lsp.config.<server_name> = {
    default_config = {
      cmd = {...},
      filetypes = {...},
      settings = {...}
    },
    on_attach = on_attach,
    capabilities = capabilities
  }

After registering:
  vim.lsp.enable("<server_name>")

Supported LSPs:
  • pyright (Python)
  • lua_ls (Lua)
  • bashls (Bash)
  • gopls (Go)
  • clangd (C/C++)
  • terraformls (Terraform)
  • yamlls (YAML)
  • jsonls (JSON)
  • marksman (Markdown)
  • powershell_es (PowerShell)

───────────────────────────────────────────────
TROUBLESHOOTING NOTES
──────────────────────
1. "cmd: expected table, got nil"
   → Means the server’s `cmd` array is missing or misformatted.
     Usually happens when `pwsh` or the LSP binary isn’t found.

2. "`require('lspconfig')` deprecated"
   → Safe to ignore after switching to `vim.lsp.config`.

3. Verify working servers:
   :LspInfo
   :LspLog
   :Mason

4. Restart Neovim after installing new servers with Mason.

───────────────────────────────────────────────
RECOMMENDED COMMANDS
──────────────────────
:Mason                  → Check and install language servers
:LspInfo                → View attached LSPs
:LspLog                 → See logs if LSPs fail to start
:checkhealth            → Validate setup
:PackerSync / :Lazy sync → Update plugins

───────────────────────────────────────────────
SUMMARY
──────────────────────
This Neovim LSP configuration:
  ✓ Uses the new vim.lsp.config API (future-proof)
  ✓ Manages servers through Mason
  ✓ Hardcodes PowerShell paths for macOS
  ✓ Provides clean keybindings and diagnostics
  ✓ Works for all major languages used in modern DevOps/IT work

───────────────────────────────────────────────
END OF FILE
───────────────────────────────────────────────

