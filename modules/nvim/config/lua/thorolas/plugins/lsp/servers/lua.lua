return function(capabilities)
  require("lspconfig").lua_ls.setup({
    capabilities = capabilities,
    settings = {
      Lua = {
        runtime = { version = "LuaJIT", },
        diagnostics = { globals = { "vim" }, },
        telemetry = { enable = false, },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
      },
    },
  })
end
