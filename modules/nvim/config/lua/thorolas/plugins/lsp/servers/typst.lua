return function(capabilities)
  require("lspconfig").tinymist.setup({
    capabilities = capabilities,
    cmd = { "tinymist", "lsp" },
    filetypes = { "typst" },
  })
end
