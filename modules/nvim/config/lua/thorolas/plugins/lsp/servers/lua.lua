return function(capabilities)
  vim.lsp.enable("lua_ls");
  vim.lsp.config("lua_ls", {
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
