return function(capabilities)
  require("lspconfig").fsautocomplete.setup({
    capabilities = capabilities,
  })
end
