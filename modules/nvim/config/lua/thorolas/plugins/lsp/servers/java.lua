return function(capabilities)
  vim.lsp.enable("jdtls")
  vim.lsp.config("jdtls", {
    capabilities = capabilities,
    cmd = { "jdtls" },
    filetypes = { "java" },
    root_dir = require('lspconfig').util.root_pattern(
      "pom.xml",
      "build.gradle",
      "build.gradle.kts",
      ".classpath",
      ".project"
    ),

    on_attach = function(client, _)
      client.server_capabilities.semanticTokensProvider = nil
      vim.lsp.handlers["textDocument/semanticTokens/full"] = function() end
      vim.lsp.handlers["textDocument/semanticTokens/range"] = function() end
    end,
  })
end
