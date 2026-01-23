return function(capabilities)
  vim.lsp.enable("clangd")
  vim.lsp.config("clangd", {
    capabilities = capabilities,
    cmd = { "clangd", "--query-driver=/nix/store/*-gcc*/bin/gcc" },
  })
end
