return function(capabilities)
  local gpp = vim.fn.exepath("clang++")

  vim.lsp.config("clangd", {
    capabilities = capabilities,
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--completion-style=detailed",
      "--function-arg-placeholders=true",
    },
  })

  vim.lsp.enable("clangd")
end
