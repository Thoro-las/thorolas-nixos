return function(capabilities)
  vim.lsp.enable("tinymist")
  vim.lsp.config("tinymist", {
    capabilities = capabilities,
    cmd = { "tinymist", "lsp" },
    filetypes = { "typst" },
  })
end
