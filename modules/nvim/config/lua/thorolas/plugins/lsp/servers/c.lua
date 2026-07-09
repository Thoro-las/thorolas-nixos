return function(capabilities)
  vim.lsp.enable("clangd")
  vim.lsp.config("clangd", {
    capabilities = capabilities,
    cmd = {
      "clangd",
      "--completion-style=detailed",
      "--function-arg-placeholders",
      "--query-driver=/nix/store/*-gcc*/bin/gcc" 
    }
  })
end
