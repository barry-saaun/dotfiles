-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.lazyvim_python_ruff = "ruff"

local opt = vim.opt

opt.guicursor = {
  "n-v-c:block",
  "i-ci-ve:block-blinkon200-blinkoff200", -- slow, steady blink
  "r-cr:hor20",
  "o:hor50",
  "sm:block-blinkon200-blinkoff200", -- fast blink on showmatch
}
