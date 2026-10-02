return function(capabilities)
  local gpp = vim.fn.exepath("g++")

  vim.lsp.config("clangd", {
    capabilities = capabilities,
    cmd = {
      "clangd",
      "--completion-style=detailed",
      "--function-arg-placeholders=true",
    },
  })

  vim.lsp.enable("clangd")
end
