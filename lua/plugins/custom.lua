-- Declare a global function to retrieve the current directory
function _G.get_oil_winbar()
  local dir = require("oil").get_current_dir()
  if dir then
    return vim.fn.fnamemodify(dir, ":~")
  else
    -- If there is no current directory (e.g. over ssh), just show the buffer name
    return vim.api.nvim_buf_get_name(0)
  end
end

return {
  {
    "jakobkhansen/journal.nvim",
    config = function()
      require("journal").setup({
        root = "~/wiki",
      })
    end,
  },
  {
    "stevearc/oil.nvim",
    config = function()
      local detail = false
      require("oil").setup({
        win_options = { winbar = "%!v:lua.get_oil_winbar()" },
        keymaps = {
          ["gd"] = {
            desc = "Toggle file detail view",
            callback = function()
              detail = not detail
              if detail then
                require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
              else
                require("oil").set_columns({ "icon" })
              end
            end,
          },
        },
      })
    end,
    opts = {},
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
  },
  {
    "rafamadriz/friendly-snippets",
    config = function()
      local ls = require("luasnip")
      -- local log = require("luasnip.util.log").new("custom")
      -- ls.log.set_loglevel("debug")
      require("luasnip.loaders.from_vscode").lazy_load()
      ls.add_snippets("all", {
        ls.snippet({
          trig = "jrnltimestamp",
          name = "jrnltimestamp",
          snippetType = "snippet",
          desc = "Insert a jrnl compliant timestamp",
        }, {
          ls.text_node(
            os.date("%Y")
              .. "-"
              .. os.date("%m")
              .. "-"
              .. os.date("%d")
              .. " "
              .. os.date("%a")
              .. " "
              .. os.date("%H")
              .. ":"
              .. os.date("%M")
          ),
        }),
      })
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
  },
  { "ziglang/zig.vim" },

  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    ---@class PluginLspOpts
    opts = {
      servers = {
        gopls = {},
        pyright = {},
        ansiblels = {},
        arduino_language_server = {},
        volar = { settings = {} },
        ruff = {},
        zls = { mason = false },
        groovyls = { mason = false },
      },
      setup = {
        groovyls = function(_, _)
          require("lspconfig").groovyls.setup({
            cmd = { "java", "-jar", vim.env.HOME .. "/bin/groovy-language-server-all.jar" },
          })
          return true
        end,
        pyright = function()
          require("lspconfig").pyright.setup({
            settings = {
              pyright = {
                -- Using Ruff's import organizer
                disableOrganizeImports = true,
              },
              python = {
                analysis = {
                  -- Ignore all files for analysis to exclusively use Ruff for linting
                  ignore = { "*" },
                },
              },
            },
          })
        end,
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "bash",
        "go",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "rust",
        "tsx",
        "typescript",
        "vim",
        "vue",
        "yaml",
        "zig",
      })
    end,
  },

  -- add telescope-fzf-native
  -- {
  --   "telescope.nvim",
  --   dependencies = {
  --     "nvim-telescope/qq",
  --     build = "make",
  --     config = function()
  --       require("telescope").load_extension("fzf")
  --       require("telescope").load_extension("notify")
  --     end,
  --   },
  -- },

  -- add symbols-outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = true,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = vim.g.border_type,
      },
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "ruff",
        "ansible-lint",
      },
    },
  },

  { "HiPhish/rainbow-delimiters.nvim" },
  { "aklt/plantuml-syntax" },
  { "dhruvasagar/vim-table-mode" },
  {
    "stevearc/conform.nvim",
    -- Everything in opts will be passed to setup()
    opts = {
      -- Define your formatters
      formatters_by_ft = {
        arduino = { "clang_format" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        cs = { "clang_format" },
        css = { "prettier" },
        cuda = { "clang_format" },
        go = { "gofmt", "goimports" },
        graphql = { "prettier" },
        groovy = { "npm_groovy_lint" },
        handlebars = { "prettier" },
        html = { "prettier" },
        htmldjango = { "prettier" },
        java = { "google_java_format" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        less = { "prettier" },
        lua = { "stylua" },
        proto = { "clang_format" },
        python = { "ruff_fix", "ruff_format" },
        -- rust = { "rustfmt" },
        scss = { "prettier" },
        svelte = { "prettier" },
        toml = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        vue = { "prettier" },
        xml = { "xmllint" },
        yaml = { "prettier" },
      },
      -- Customize formatters
      formatters = {
        prettier = {
          command = "/usr/local/bin/prettier",
          prepend_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
        },
        shfmt = {
          prepend_args = { "-i", "2" },
        },
        npm_groovy_lint = {
          command = "/usr/local/bin/npm-groovy-lint",
          prepend_args = { "--format" },
        },
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        html = { "tidy" },
      },
    },
  },

  { "mzlogin/vim-markdown-toc" },

  { "tpope/vim-sleuth" },

  { "khaveesh/vim-fish-syntax" },

  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip").filetype_extend("svelte", { "javascript" })
      require("luasnip").filetype_extend("typescript", { "javascript" })
    end,
  },

  { "leafOfTree/vim-svelte-plugin" },

  {
    "folke/which-key.nvim",
    opts = { preset = "modern" },
  },

  { "lewis6991/spaceless.nvim" },

  { "dkarter/bullets.vim" },

  { "pearofducks/ansible-vim" },

  { "mfussenegger/nvim-jdtls" },

  {
    "windwp/nvim-ts-autotag",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-ts-autotag").setup({
        filetypes = {
          "astro",
          "djangohtml",
          "glimmer",
          "handlebars",
          "hbs",
          "html",
          "javascript",
          "javascriptreact",
          "jsx",
          "markdown",
          "php",
          "rescript",
          "svelte",
          "tsx",
          "typescript",
          "typescriptreact",
          "vue",
          "xml",
        },
      })
    end,
  },

  {
    "johmsalas/text-case.nvim",
    config = function()
      require("textcase").setup({})
    end,
  },

  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({})
    end,
  },
}
