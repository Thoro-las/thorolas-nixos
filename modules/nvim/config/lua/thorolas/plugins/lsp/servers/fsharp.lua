return function(capabilities)
  vim.lsp.enable("fsautocomplete")
  vim.lsp.config("fsautocomplete", {
    capabilities = capabilities,
    cmd = { "fsautocomplete", "--background-service-enabled" },
    filetypes = { "fsharp" },
    root_dir = require('lspconfig').util.root_pattern("*.fsproj", "*.sln", ".git"),
    single_file_support = true,
  })
end
