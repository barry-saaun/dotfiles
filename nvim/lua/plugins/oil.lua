return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  opts = {
    keymaps = {
      -- Navigate like Netrw / NvimTree
      ["h"] = "actions.parent",
      ["l"] = "actions.select",

      -- Open with system default program (macOS: "open", Linux: "xdg-open")
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
  end,
}
