return function(capabilities)
  require('lspconfig').jdtls.setup({
    capabilities = capabilities,
    cmd = { "jdtls" },
    filetypes = { "java" },
    root_dir = require('lspconfig').util.root_pattern(".classpath", ".project"),
    on_attach = function(client, _)
      client.server_capabilities.semanticTokensProvider = nil
      vim.lsp.handlers["textDocument/semanticTokens/full"] = function() end
      vim.lsp.handlers["textDocument/semanticTokens/range"] = function() end
    end,
  })
end
