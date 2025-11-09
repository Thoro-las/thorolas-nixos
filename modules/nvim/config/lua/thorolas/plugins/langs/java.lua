return {
  "mfussenegger/nvim-jdtls",
  ft = {"java"},
  config = function()
    local jdtls = require('jdtls')
    local root_markers = { '.project', '.classpath' }
    local root_dir = require('jdtls.setup').find_root(root_markers)

    local workspace_dir = vim.fn.stdpath('data') .. '/jdtls-workspace/' .. vim.fn.fnamemodify(root_dir, ':p:h:t')

    local cmd = {
      'jdtls',
      '-data', workspace_dir
    }

    local config = {
      cmd = cmd,
      root_dir = root_dir,
      settings = {
        java = {
          project = {
            referencedLibraries = { "lib/**/*.jar" },
            outputPath = "build/"
          },
          -- sourcePaths = { "src", "res" },
        },
      },

      init_options = {
        bundles = {},
      },

      on_attach = function(client, _)
        client.server_capabilities.semanticTokensProvider = nil
      end,
    }

    jdtls.start_or_attach(config)
  end,
}
