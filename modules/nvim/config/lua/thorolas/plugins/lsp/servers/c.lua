return function(capabilities)
  require("lspconfig").clangd.setup({
    capabilities = capabilities,
    cmd = { "clangd", "--query-driver=/nix/store/*-gcc*/bin/gcc" },
  })
end
