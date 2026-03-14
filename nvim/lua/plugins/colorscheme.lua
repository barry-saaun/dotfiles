return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 100,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
        show_end_of_buffer = false,
        integrations = {
          treesitter_context = true,
        },
      })
      vim.cmd.colorscheme("catppuccin-nvim")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-nvim",
    },
  },
}
