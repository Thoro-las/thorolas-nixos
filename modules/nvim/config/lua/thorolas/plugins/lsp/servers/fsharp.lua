return function(capabilities)
  require('lspconfig').fsautocomplete.setup({
    capabilities = capabilities,
    cmd = { "fsautocomplete", "--background-service-enabled" },
    filetypes = { "fsharp" },
    root_dir = require('lspconfig').util.root_pattern("*.fsproj", "*.sln", ".git"),
    single_file_support = true,
  })
end
