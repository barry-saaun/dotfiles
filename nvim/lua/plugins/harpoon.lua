return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  config = function()
    local harpoon = require("harpoon")
    ---@diagnostic disable-next-line: missing-parameter
    harpoon:setup()

    -- basic telescope configuration
    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers")
        .new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        })
        :find()
    end
    vim.keymap.set("n", "<C-e>", function()
      toggle_telescope(harpoon:list())
    end, { desc = "Open harpoon window" })

    local function map(lhs, rhs, opts)
      vim.keymap.set("n", lhs, rhs, opts or {})
    end
    map("<leader>ha", function()
      harpoon:list():add()
    end)
    map("<leader>hm", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)
    map("<leader>1", function()
      harpoon:list():select(1)
    end)
    map("<leader>2", function()
      harpoon:list():select(2)
    end)
    map("<leader>3", function()
      harpoon:list():select(3)
    end)
    map("<leader>4", function()
      harpoon:list():select(4)
    end)
    map("<leader>5", function()
      harpoon:list():select(5)
    end)
  end,
}
