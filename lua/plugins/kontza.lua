return {
  { "mzlogin/vim-markdown-toc" },

  { "tpope/vim-sleuth" },

  { "khaveesh/vim-fish-syntax" },

  { "simrat39/rust-tools.nvim" },

  { "lewis6991/spaceless.nvim" },

  { "dkarter/bullets.vim" },

  { "pearofducks/ansible-vim" },

  { "lervag/wiki" },

  {
    "windwp/nvim-ts-autotag",
    depends = "nvim-treesitter/nvim-treesitter",
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
    ft = { "scss", "css", "html" },
    config = function()
      require("colorizer").setup()
    end,
    disable = false,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        width = 30,
      },
    },
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = {
      ensure_installed = {
        "prettier",
        "black",
        "stylua",
        "rustfmt",
        "google_gava_format",
        "xmllint",
      },
    },
    config = function()
      local null_ls = require("null-ls")
      local formatting = null_ls.builtins.formatting
      local diagnostics = null_ls.builtins.diagnostics
      null_ls.setup({
        debug = false,
        sources = {
          formatting.prettier.with({
            extra_filetypes = { "toml" },
            extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
            filetypes = {
              "javascript",
              "javascriptreact",
              "typescript",
              "typescriptreact",
              "vue",
              "css",
              "scss",
              "less",
              "html",
              "json",
              "jsonc",
              "yaml",
              "graphql",
              "handlebars",
            },
          }),
          formatting.black.with({ extra_args = { "--fast" } }),
          formatting.stylua,
          formatting.rustfmt,
          formatting.google_java_format,
          diagnostics.flake8.with({
            args = { "--max-line-length", "88", "--format", "default", "--stdin-display-name", "$FILENAME", "-" },
          }),
          diagnostics.tidy,
          formatting.xmllint,
        },
      })
    end,
  },
}
