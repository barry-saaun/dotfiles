return {
  "stevearc/oil.nvim",
  opts = {},
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  config = function(_, opts)
    require("oil").setup(opts)

    vim.keymap.set("n", "<BS>", function()
      require("oil").open("..")
    end, { desc = "Go up directory in Oil" })
  end,
}
