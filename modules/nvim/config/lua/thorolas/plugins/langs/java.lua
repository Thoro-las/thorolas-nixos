return {
  "mfussenegger/nvim-jdtls",
  ft = { "java" },
  config = function()
    local jdtls = require("jdtls")

    local root_dir = require("jdtls.setup").find_root({ "gradlew", "mvnw", ".git" })

    if root_dir == nil then
      vim.notify("No project root found for Java (gradle/maven/git)", vim.log.levels.WARN)
      return
    end

    local config = {
      cmd = { "jdtls" },
      root_dir = root_dir,
      settings = {
        java = {
          format = { enabled = true },
        },
      },
      init_options = {
        bundles = {},
      },
      flags = {
        allow_incremental_sync = true,
      },
    }

    jdtls.start_or_attach(config)
  end,
}
