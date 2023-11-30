return {
  { "dhruvasagar/vim-table-mode" },
  {
    "stevearc/conform.nvim",
    -- Everything in opts will be passed to setup()
    opts = {
      -- Define your formatters
      formatters_by_ft = {
        css = { "prettier" },
        graphql = { "prettier" },
        handlebars = { "prettier" },
        html = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        less = { "prettier" },
        scss = { "prettier" },
        svelte = { "prettier" },
        toml = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        vue = { "prettier" },
        yaml = { "prettier" },
        java = { "google_java_format" },
        lua = { "stylua" },
        python = { "isort", "black" },
        rust = { "rustfmt" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        cs = { "clang_format" },
        cuda = { "clang_format" },
        proto = { "clang_format" },
        arduino = { "clang_format" },
      },
      -- Customize formatters
      formatters = {
        black = {
          prepend_args = { "--fast" },
        },
        prettier = {
          prepend_args = { "--no-semi", "--single-quote", "--jsz-single-quote" },
        },
        shfmt = {
          prepend_args = { "-i", "2" },
        },
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        html = { "tidy" },
        python = { "flake8" },
      },
      linters = {
        flake8 = {
          args = {
            "--max-line-length",
            "88",
            "--format=%(path)s:%(row)d:%(col)d:%(code)s:%(text)s",
            "--no-show-source",
            "-",
          },
        },
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

  {
    "simrat39/rust-tools.nvim",
    dependencies = "neovim/nvim-lspconfig",
    opts = {
      server = {
        cmd = { "ra-multiplex" },
      },
    },
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
          "html",
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact",
          "svelte",
          "vue",
          "tsx",
          "jsx",
          "rescript",
          "xml",
          "php",
          "markdown",
          "astro",
          "glimmer",
          "handlebars",
          "hbs",
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

  -- {
  --   "nvimtools/none-ls.nvim",
  --   opts = {
  --     ensure_installed = {
  --       "prettier",
  --       "black",
  --       "stylua",
  --       "rustfmt",
  --       "google_gava_format",
  --       "xmllint",
  --     },
  --   },
  --   config = function()
  --     local null_ls = require("null-ls")
  --     local formatting = null_ls.builtins.formatting
  --     local diagnostics = null_ls.builtins.diagnostics
  --     null_ls.setup({
  --       debug = false,
  --       sources = {
  --         formatting.prettier.with({
  --           extra_filetypes = { "toml" },
  --           extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
  --           filetypes = {
  --             "css",
  --             "graphql",
  --             "handlebars",
  --             "html",
  --             "javascript",
  --             "javascriptreact",
  --             "json",
  --             "jsonc",
  --             "less",
  --             "scss",
  --             "svelte",
  --             "typescript",
  --             "typescriptreact",
  --             "vue",
  --             "yaml",
  --           },
  --         }),
  --         formatting.clang_format.with({
  --           filetypes = { "c", "cpp", "cs", "java", "cuda", "proto", "arduino" },
  --         }),
  --         formatting.black.with({ extra_args = { "--fast" } }),
  --         formatting.stylua,
  --         formatting.rustfmt,
  --         formatting.google_java_format,
  --         diagnostics.flake8.with({
  --           args = { "--max-line-length", "88", "--format", "default", "--stdin-display-name", "$FILENAME", "-" },
  --         }),
  --         diagnostics.tidy,
  --         formatting.xmllint,
  --       },
  --     })
  --   end,
  -- },
}
