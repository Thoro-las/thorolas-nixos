return function(capabilities)
  require("lspconfig").jdtls.setup({
    capabilities = capabilities,
  })
end
