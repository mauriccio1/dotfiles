-- ═══════════════════════════════════════════════════════════════
-- BLOOD ANGELS NEOVIM CONFIGURATION
-- "Only in death does duty end" - Sanguinius, Primarch of the IX Legion
-- BALANCED EDITION - Noble Colors, Clear Readability
-- ═══════════════════════════════════════════════════════════════

-- ~/.config/nvim/lua/plugins/init.lua
return {
  -- ═══════════════════════════════════════════════════════════════
  -- BLOOD ANGELS COLORSCHEME - BALANCED
  -- ═══════════════════════════════════════════════════════════════
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",
        on_colors = function(colors)
          -- Blood Angels Balanced Palette
          colors.bg = "#0a0000"           -- Deep black with slight red
          colors.bg_dark = "#050000"      -- Darker
          colors.bg_highlight = "#1a0505" -- Subtle highlight
          colors.bg_visual = "#2a0a0a"    -- Visual selection
          colors.fg = "#e8d5c4"           -- Warm parchment white
          colors.fg_dark = "#a89984"      -- Aged parchment
          
          -- Chapter Colors - Rich but not blinding
          colors.red = "#dc2626"          -- Blood Angels red
          colors.red1 = "#ef4444"         -- Bright blood
          colors.orange = "#d97706"       -- Rich gold/bronze
          colors.yellow = "#eab308"       -- Golden (Emperor's light)
          colors.green = "#16a34a"        -- Success green
          colors.cyan = "#06b6d4"         -- Power armor blue
          colors.blue = "#3b82f6"         -- Bright blue
          colors.magenta = "#e11d48"      -- Rose red
          colors.purple = "#9333ea"       -- Purple (the Flaw)
          
          -- Git colors
          colors.git.add = "#16a34a"      -- Green
          colors.git.change = "#eab308"   -- Gold
          colors.git.delete = "#dc2626"   -- Red
          
          -- Diagnostics
          colors.error = "#ef4444"        -- Clear red
          colors.warning = "#f59e0b"      -- Orange
          colors.info = "#3b82f6"         -- Blue
          colors.hint = "#94a3b8"         -- Grey
        end,
        on_highlights = function(hl, c)
          -- Balanced base
          hl.Normal = { fg = "#e8d5c4", bg = "#0a0000" }
          hl.NormalFloat = { fg = "#e8d5c4", bg = "#0f0000" }
          hl.FloatBorder = { fg = "#dc2626", bg = "#0f0000" }
          
          -- Cursor - visible but not blinding
          hl.Cursor = { fg = "#0a0000", bg = "#dc2626" }
          hl.CursorLine = { bg = "#1a0505" }
          hl.CursorLineNr = { fg = "#ef4444", bold = true }
          hl.LineNr = { fg = "#6b5d54" }
          
          -- Selection
          hl.Visual = { bg = "#2a0a0a" }
          
          -- Search
          hl.Search = { fg = "#0a0000", bg = "#d97706", bold = true }
          hl.IncSearch = { fg = "#0a0000", bg = "#ef4444", bold = true }
          
          -- Status
          hl.StatusLine = { fg = "#e8d5c4", bg = "#1a0000" }
          hl.StatusLineNC = { fg = "#6b5d54", bg = "#0a0000" }
          
          -- Diagnostic - Clear but not harsh
          hl.DiagnosticError = { fg = "#ef4444", bold = true }
          hl.DiagnosticWarn = { fg = "#f59e0b", bold = true }
          hl.DiagnosticInfo = { fg = "#3b82f6" }
          hl.DiagnosticHint = { fg = "#94a3b8" }
          
          -- Underlines
          hl.DiagnosticUnderlineError = { undercurl = true, sp = "#ef4444" }
          hl.DiagnosticUnderlineWarn = { undercurl = true, sp = "#f59e0b" }
          hl.DiagnosticUnderlineInfo = { undercurl = true, sp = "#3b82f6" }
          hl.DiagnosticUnderlineHint = { undercurl = true, sp = "#94a3b8" }
          
          -- LSP
          hl.LspReferenceText = { bg = "#1a0a0a" }
          hl.LspReferenceRead = { bg = "#1a0a0a" }
          hl.LspReferenceWrite = { bg = "#1a0a0a" }
          
          -- Tree-sitter - Balanced syntax
          hl["@keyword"] = { fg = "#dc2626", bold = true }
          hl["@function"] = { fg = "#d97706", bold = true }
          hl["@function.call"] = { fg = "#d97706" }
          hl["@variable"] = { fg = "#e8d5c4" }
          hl["@variable.builtin"] = { fg = "#ef4444" }
          hl["@string"] = { fg = "#16a34a" }
          hl["@number"] = { fg = "#f59e0b" }
          hl["@boolean"] = { fg = "#f59e0b" }
          hl["@comment"] = { fg = "#6b5d54", italic = true }
          hl["@type"] = { fg = "#eab308", bold = true }
          hl["@constant"] = { fg = "#f59e0b" }
          hl["@operator"] = { fg = "#dc2626" }
          hl["@punctuation.bracket"] = { fg = "#a89984" }
          hl["@tag"] = { fg = "#dc2626" }
          hl["@attribute"] = { fg = "#d97706" }
          
          -- Popup menu
          hl.Pmenu = { fg = "#e8d5c4", bg = "#1a0a0a" }
          hl.PmenuSel = { fg = "#0a0000", bg = "#dc2626", bold = true }
          hl.PmenuSbar = { bg = "#1a0a0a" }
          hl.PmenuThumb = { bg = "#dc2626" }
        end,
      })
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  -- ═══════════════════════════════════════════════════════════════
  -- ALPHA DASHBOARD - SANGUINIUS SHRINE
  -- ═══════════════════════════════════════════════════════════════
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- Blood Angels ASCII art
      dashboard.section.header.val = {
        [[                                                                    ]],
        [[        ██████╗ ██╗      ██████╗  ██████╗ ██████╗                  ]],
        [[        ██╔══██╗██║     ██╔═══██╗██╔═══██╗██╔══██╗                 ]],
        [[        ██████╔╝██║     ██║   ██║██║   ██║██║  ██║                 ]],
        [[        ██╔══██╗██║     ██║   ██║██║   ██║██║  ██║                 ]],
        [[        ██████╔╝███████╗╚██████╔╝╚██████╔╝██████╔╝                 ]],
        [[        ╚═════╝ ╚══════╝ ╚═════╝  ╚═════╝ ╚═════╝                  ]],
        [[                                                                    ]],
        [[         █████╗ ███╗   ██╗ ██████╗ ███████╗██╗     ███████╗        ]],
        [[        ██╔══██╗████╗  ██║██╔════╝ ██╔════╝██║     ██╔════╝        ]],
        [[        ███████║██╔██╗ ██║██║  ███╗█████╗  ██║     ███████╗        ]],
        [[        ██╔══██║██║╚██╗██║██║   ██║██╔══╝  ██║     ╚════██║        ]],
        [[        ██║  ██║██║ ╚████║╚██████╔╝███████╗███████╗███████║        ]],
        [[        ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝╚══════╝╚══════╝        ]],
        [[                                                                    ]],
        [[              ⚔️  IX LEGION • SONS OF SANGUINIUS ⚔️                ]],
        [[                                                                    ]],
      }

      -- Quotes from Sanguinius and Blood Angels lore
      local quotes = {
        '"It is better by far to embrace the hard truth than a reassuring fable." - Sanguinius',
        '"Only in death does duty end." - Sanguinius',
        '"The warrior who acts out of honour cannot fail. His duty is honour itself." - Sanguinius',
        '"I am the blade of humanity, the shield of the Emperor." - Blood Angels Creed',
        '"Do not ask what you can achieve, but what you must endure." - Sanguinius',
        '"Angels of Death, we are the Emperor\'s wrath made manifest." - Blood Angels',
        '"For Sanguinius! For the Emperor!" - Battle Cry of the IX Legion',
      }

      -- Random quote
      math.randomseed(os.time())
      dashboard.section.footer.val = quotes[math.random(#quotes)]

      -- Menu
      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find Files", ":Telescope find_files<CR>"),
        dashboard.button("r", "  Recent Files", ":Telescope oldfiles<CR>"),
        dashboard.button("g", "  Search Text", ":Telescope live_grep<CR>"),
        dashboard.button("e", "  File Explorer", ":NvimTreeToggle<CR>"),
        dashboard.button("c", "  Configuration", ":e $MYVIMRC<CR>"),
        dashboard.button("q", "  Quit", ":qa<CR>"),
      }

      -- Colors
      dashboard.section.header.opts.hl = "DiagnosticError"
      dashboard.section.buttons.opts.hl = "Keyword"
      dashboard.section.footer.opts.hl = "Comment"

      alpha.setup(dashboard.opts)

      -- Disable folding on alpha buffer
      vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
    end,
  },

  -- ═══════════════════════════════════════════════════════════════
  -- LUALINE - BLOOD ANGELS STATUS
  -- ═══════════════════════════════════════════════════════════════
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- Custom mode names
      local mode_map = {
        ['n']    = 'SANGUINARY',
        ['no']   = 'SANGUINARY',
        ['v']    = 'ASSAULT',
        ['V']    = 'ASSAULT',
        ['\22']  = 'ASSAULT',
        ['s']    = 'ASSAULT',
        ['S']    = 'ASSAULT',
        ['\19']  = 'ASSAULT',
        ['i']    = 'DEATH COMPANY',
        ['R']    = 'CHAPLAIN',
        ['c']    = 'COMMAND',
        ['r']    = 'APOTHECARY',
        ['!']    = 'TECHMARINE',
        ['t']    = 'TECHMARINE',
      }

      local function get_mode()
        local mode_code = vim.api.nvim_get_mode().mode
        return mode_map[mode_code] or 'BATTLE-BROTHER'
      end

      -- Blood Angels theme - Balanced
      local blood_angels = {
        normal = {
          a = { fg = '#0a0000', bg = '#dc2626', gui = 'bold' },
          b = { fg = '#e8d5c4', bg = '#1a0000' },
          c = { fg = '#a89984', bg = '#0a0000' },
        },
        insert = {
          a = { fg = '#0a0000', bg = '#ef4444', gui = 'bold' },
          b = { fg = '#e8d5c4', bg = '#1a0000' },
        },
        visual = {
          a = { fg = '#0a0000', bg = '#d97706', gui = 'bold' },
          b = { fg = '#e8d5c4', bg = '#1a0000' },
        },
        replace = {
          a = { fg = '#0a0000', bg = '#eab308', gui = 'bold' },
          b = { fg = '#e8d5c4', bg = '#1a0000' },
        },
        command = {
          a = { fg = '#0a0000', bg = '#a89984', gui = 'bold' },
          b = { fg = '#e8d5c4', bg = '#1a0000' },
        },
        inactive = {
          a = { fg = '#6b5d54', bg = '#0a0000' },
          b = { fg = '#6b5d54', bg = '#0a0000' },
          c = { fg = '#6b5d54', bg = '#0a0000' },
        },
      }

      require("lualine").setup({
        options = {
          theme = blood_angels,
          component_separators = { left = '│', right = '│' },
          section_separators = { left = '', right = '' },
          icons_enabled = true,
          globalstatus = true,
        },
        sections = {
          lualine_a = {
            {
              get_mode,
              icon = '⚔️',
            }
          },
          lualine_b = {
            {
              'branch',
              icon = '🩸',
            }
          },
          lualine_c = {
            {
              'filename',
              path = 1,
              color = { fg = '#e8d5c4' },
            }
          },
          lualine_x = {
            {
              'diagnostics',
              sources = { 'nvim_lsp' },
              symbols = {
                error = '⚠️ ',
                warn = '⚡ ',
                info = 'ℹ️ ',
                hint = '💡 '
              },
              colored = true,
            }
          },
          lualine_y = {
            {
              'filetype',
              colored = true,
            }
          },
          lualine_z = {
            { 'location' },
            { 'progress' }
          }
        },
      })
    end,
  },

  -- ═══════════════════════════════════════════════════════════════
  -- TELESCOPE
  -- ═══════════════════════════════════════════════════════════════
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          prompt_prefix = "🔍 ",
          selection_caret = "⚔️ ",
          entry_prefix = "  ",
          border = true,
          borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
          layout_config = {
            horizontal = {
              prompt_position = "top",
            },
          },
          sorting_strategy = "ascending",
          color_devicons = true,
        },
      })

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help" })
    end,
  },

  -- ═══════════════════════════════════════════════════════════════
  -- TREESITTER
  -- ═══════════════════════════════════════════════════════════════
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "python", "lua", "vim", "bash", "json", "yaml",
          "markdown", "terraform", "hcl", "go", "c",
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
      })
    end,
  },

  -- ═══════════════════════════════════════════════════════════════
  -- LSP SUPPORT
  -- ═══════════════════════════════════════════════════════════════
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
  },

  -- ═══════════════════════════════════════════════════════════════
  -- COMPLETION
  -- ═══════════════════════════════════════════════════════════════
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      cmp.setup({
        enabled = function()
          return vim.bo.buftype ~= "prompt"
        end,
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:Pmenu,FloatBorder:DiagnosticError,CursorLine:PmenuSel,Search:None",
          }),
          documentation = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:Pmenu,FloatBorder:DiagnosticError",
          }),
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = '...',
            before = function(entry, vim_item)
              -- Show source name
              vim_item.menu = ({
                nvim_lsp = "[LSP]",
                luasnip = "[Snip]",
                buffer = "[Buf]",
                path = "[Path]",
              })[entry.source.name]
              return vim_item
            end,
          }),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer", keyword_length = 3 },
          { name = "path" },
        },
      })
    end,
  },  

 { "onsails/lspkind.nvim" },

  -- ═══════════════════════════════════════════════════════════════
  -- GIT SIGNS
  -- ═══════════════════════════════════════════════════════════════
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add          = { text = '┃' },
          change       = { text = '┃' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        current_line_blame = true,
        current_line_blame_opts = {
          delay = 300,
        },
        current_line_blame_formatter = '🩸 <author>, <author_time:%Y-%m-%d> - <summary>',
      })
    end,
  },

  -- ═══════════════════════════════════════════════════════════════
  -- FILE EXPLORER
  -- ═══════════════════════════════════════════════════════════════
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = {
          side = "left",
          width = 35,
        },
        renderer = {
          highlight_opened_files = "all",
          highlight_git = true,
          icons = {
            show = {
              git = true,
              folder = true,
              file = true,
            },
          },
        },
      })
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle Explorer" })
    end,
  },

  -- ═══════════════════════════════════════════════════════════════
  -- TERMINAL
  -- ═══════════════════════════════════════════════════════════════
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require("toggleterm").setup{
        size = 20,
        open_mapping = [[<C-\>]],
        direction = 'horizontal',
        shade_terminals = true,
        persist_size = true,
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = 'curved',
        },
      }
      
      local Terminal = require('toggleterm.terminal').Terminal
      
      local python = Terminal:new({ cmd = "python3", hidden = true })
      vim.keymap.set('n', '<leader>tp', function() python:toggle() end, { desc = "Python REPL" })
      
      local node = Terminal:new({ cmd = "node", hidden = true })
      vim.keymap.set('n', '<leader>tn', function() node:toggle() end, { desc = "Node REPL" })
    end
  },

  -- ═══════════════════════════════════════════════════════════════
  -- AUTO PAIRS
  -- ═══════════════════════════════════════════════════════════════
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  -- ═══════════════════════════════════════════════════════════════
  -- COMMENT
  -- ═══════════════════════════════════════════════════════════════
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  -- ═══════════════════════════════════════════════════════════════
  -- INDENT BLANKLINE
  -- ═══════════════════════════════════════════════════════════════
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = {
          char = "│",
          highlight = "Comment",
        },
        scope = {
          enabled = true,
          show_start = true,
          show_end = false,
          highlight = "DiagnosticError",
        },
      })
    end,
  },
}
