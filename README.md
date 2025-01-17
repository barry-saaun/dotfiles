# 🚀 My Development Environment Setup

This repository contains configuration files (**dotfiles**) used personally by me to set up and customise a development environment. The configs are optimised and tailored to my style of development to boost productivity.

# 📋 Table of Contents

- Features
- Tools Included
- Configuration Overview

## ✨ Features

- Seamless integration with MacOS.
- Customisations for Neovim to support advanced, yet, intuitive editing and workflow.
- Aesthetic-focus with custom MacOS menu bar setup with Sketchybar.

## 🛠️ Tools Included

- [Terminal (Alacritty)](https://alacritty.org/)
- [Neovim](https://neovim.io/)
- [Sketchybar](https://github.com/FelixKratz/SketchyBar)
- [Tmux](https://github.com/tmux/tmux/wiki)
- [Yabai](https://github.com/koekeishiya/yabai)

## ⚙️ Configuration Overview

### 🖥️ Terminal Setup

I've switched from [iTerm2](https://iterm2.com/) to [Alacritty](https://alacritty.org/) because of its seamless configuration.

The colorscheme used is `nightowl` at [~/.config/alacritty/themes/night_owl.toml](https://github.com/barry-saaun/dotfiles/blob/main/alacritty/themes/night_owl.toml)

- **Shell**: zsh
  - Uses `oh-my-zsh` with `powerlevel10k` setup theme for appearance setup in the terminal.
  - Plugins include `zsh-autosuggestions` and `zsh-syntax-highlighting`.
  - **Config file**: [.zshrc](https://github.com/barry-saaun/dotfiles/blob/main/zshrc)
- **Setup Requires:**
  - `brew`
  - `node`
  - `ruby`
  - Xcode Command Line
  - Nerd Font
- Favourite CLI Tools:
  - lazygit
  - fzf
  - bat
  - thefuck
  - colorls
  - ripgrep

### 📜 Neovim

This config uses [LazyVim](https://www.lazyvim.org/) by **Folke**, although, not the exact same as the starter pack.

The _plugin manager:_ [folke/lazy.nvim](https://github.com/folke/lazy.nvim)

```
brew install neovim
git clone https://github.com/LazyVim/starter ~/.config/nvim
```

All the plugins can be found and inspect at [dotfiles/nvim/lazy-lock.json](https://github.com/barry-saaun/dotfiles/blob/main/nvim/lazy-lock.json)

#### Personal Favourite Plugins

- [Harpoon2](https://github.com/ThePrimeagen/harpoon/tree/harpoon2)
- [Telescope-file-browser](https://github.com/nvim-telescope/telescope-file-browser.nvim)
- [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)
- [night-owl.nvim](https://github.com/oxfist/night-owl.nvim)

### 🖲️ Tmux

**`Ctrl + a`**: keybinding.

#### Plugins

- [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect)
- [tmux-sensibe](https://github.com/tmux-plugins/tmux-sensible)
- [tmux-yank](https://github.com/tmux-plugins/tmux-yank)
- [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)

#### Statusline

The tmux statusline is directly inspired by [craftzdog](https://github.com/craftzdog/dotfiles-public/blob/master/.config/tmux/statusline.conf). Many thanks! 🙏

### 🧩 Yabai

**Yabai** is a tilling window management, practically the same as i3 but for MacOS.

Although, Yabai has worked well for me in terms of its simplicity, due to the fact that I have to disable the System Integrity Protection, I am considering moving to [Aerospace](https://github.com/nikitabobko/AeroSpace).

✨ **Direct Integration with Sketchybar**, which adds extra padding to the _'menu bar'_.

```shell
yabai -m config external_bar all:23:0
```
