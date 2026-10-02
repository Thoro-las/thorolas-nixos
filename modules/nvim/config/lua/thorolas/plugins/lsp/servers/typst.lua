return function(capabilities)
  vim.lsp.config("tinymist", {
    capabilities = capabilities,
    cmd = { "tinymist", "lsp" },
    filetypes = { "typst" },
    settings = {
      formatterMode = "typstyle",
    }
  })

  vim.lsp.enable("tinymist")
end
