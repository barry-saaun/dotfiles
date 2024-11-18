return {
  "oxfist/night-owl.nvim",
  lazy = false,
  priority = 100,
  config = function()
    require("night-owl").setup({
      transparent_background = true,
    })
    vim.cmd.colorscheme("night-owl")
  end,
}
