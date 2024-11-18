return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
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
}
