return {
  {
    "mfussenegger/nvim-jdtls",
    opts = function(_, opts)
      -- Your existing opts...
      opts.settings = vim.tbl_deep_extend("force", opts.settings or {}, {
        java = {
          configuration = {
            runtimes = {
              {
                name = "JavaSE-17",
                path = "/Applications/IntelliJ IDEA CE.app/Contents/jbr/Contents/Home",
              },
            },
          },
        },
      })
      -- Ensure cmd uses Java 21 (Mason's jdtls script will pick JAVA_HOME)
      local jbr21_home = "/opt/homebrew/opt/openjdk@21" -- e.g., from step 1
      opts.cmd = vim.list_extend({ string.format("%s/bin/java", jbr21_home) }, opts.cmd or {})
      return opts
    end,
  },
}
