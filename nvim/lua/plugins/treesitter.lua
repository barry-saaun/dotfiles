return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "r",
        "c",
        "typescript",
        "gitignore",
        "graphql",
        "http",
        "rust",
        "css",
        "scss",
        "sql",
        "svelte",
        "cmake",
        "cpp",
        "go",
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      -- MDX
      vim.filetype.add({
        extension = {
          mdx = "mdx",
        },
      })
      vim.treesitter.language.register("markdown", "mdx")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesitter-context").setup({
        enable = true,
        max_lines = 3,
        trim_scope = "outer",
        mode = "cursor",
      })
    end,
    lazy = false,
    keys = {
      {
        "[c",
        function()
          require("treesitter-context").go_to_context(vim.v.count1)
        end,
        desc = "Jump to treesitter context",
      },
    },
  },
}
