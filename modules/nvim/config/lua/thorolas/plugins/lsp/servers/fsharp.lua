return function(capabilities)
  vim.lsp.enable("fsautocomplete")
  vim.lsp.config("fsautocomplete", {
    capabilities = capabilities,
    cmd = { "fsautocomplete" },
    filetypes = { "fsharp" },

    single_file_support = true,
    -- root_dir = require('lspconfig').util.root_pattern(
    --   "*.fsproj",
    --   "*.sln",
    --   ".git"
    -- ),
  })
end
