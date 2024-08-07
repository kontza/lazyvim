return {
  {
    "renerocksai/telekasten.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telekasten").setup({
        home = vim.fn.expand("~/wiki"), -- Put the name of your notes directory here
        weeklies = vim.fn.expand("~/wiki/weeklies"),
        vaults = {
          omat = {
            home = vim.fn.expand("~/wiki/omat"),
          },
          vnk = {
            home = vim.fn.expand("~/wiki/vnk"),
          },
        },
      })
    end,
  },
  { "nvim-telekasten/calendar-vim" },
  { "ziglang/zig.vim" },
  {
    "ckipp01/nvim-jenkinsfile-linter",
    dependencies = "nvim-lua/plenary.nvim",
  },

  -- add pyright to lspconfig
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
        pyright = {
          mason = false,
        },
        ansiblels = {},
        arduino_language_server = {},
        volar = { settings = {} },
        ruff_lsp = {},
        zls = { mason = false },
        groovyls = { mason = false },
      },
      setup = {
        groovyls = function(_, opts)
          require("lspconfig").groovyls.setup({
            cmd = { "java", "-jar", vim.env.HOME .. "/bin/groovy-language-server-all.jar" },
          })
          return true
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
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
        require("telescope").load_extension("notify")
      end,
    },
  },

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
        "ruff-lsp",
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
    "folke/noice.nvim",
    config = function()
      local noice = require("noice")
      noice.setup({
        routes = {
          {
            view = "notify",
            filter = { event = "msg_showmode" },
          },
        },
      })
    end,
  },

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
    config = function()
      local wk = require("which-key")
      wk.setup({
        window = {
          border = vim.g.border_type,
        },
      })
    end,
  },

  { "lewis6991/spaceless.nvim" },

  { "dkarter/bullets.vim" },

  { "pearofducks/ansible-vim" },

  { "lervag/wiki" },

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
      require("telescope").load_extension("textcase")
    end,
  },

  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        width = 30,
      },
      filesystem = {
        filtered_items = {
          visible = true,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            ".git",
            ".DS_Store",
            "thumbs.db",
          },
          never_show = {},
        },
      },
    },
  },
}
