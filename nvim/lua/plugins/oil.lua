return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  opts = {
    -- Show nice metadata view
    columns = { "permissions", "mtime", "size", "icon" },

    -- LSP-aware renames/moves if supported
    lsp_file_methods = { enabled = true },

    -- Floating window styling
    float = {
      padding = 2,
      max_width = 0.9,
      max_height = 0.7,
      border = "rounded",
      win_options = {
        winblend = 10,
        cursorline = true,
      },
    },

    view_options = {
      show_hidden = true, -- like `ls -a`
      -- sorter will be injected by the config function below
    },

    -- Keymaps inside Oil (we'll inject the toggle below too)
    keymaps = {
      ["<BS>"] = "actions.parent", -- go up dir
      ["<CR>"] = "actions.select", -- open file **or** enter dir
      ["<Esc>"] = "actions.close", -- quit Oil
      ["<C-o>"] = function()
        local oil = require("oil")
        local entry = oil.get_cursor_entry()
        if not entry then
          return
        end
        local path = oil.get_current_dir() .. entry.name
        local opener = vim.fn.has("macunix") == 1 and "open" or "xdg-open"
        vim.fn.jobstart({ opener, path }, { detach = true })
      end,
    },
  },
  config = function(_, opts)
    require("oil").setup(opts)

    -- Open Oil in floating mode with "-"
    vim.keymap.set("n", "-", "<cmd>Oil --float<CR>", { desc = "Open Oil (float)" })
  end,
}
