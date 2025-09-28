return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "selene",
        "luacheck",
        "shellcheck",
        "shfmt",
        "tailwindcss-language-server",
        "typescript-language-server",
        "css-lsp",
        "bash-language-server",
      })
    end,
  },
  {
    require("lspconfig").lua_ls.setup({
      settings = {
        Lua = {
          inlay_hint = { enable = false },
        },
      },
    }),
  },
}
