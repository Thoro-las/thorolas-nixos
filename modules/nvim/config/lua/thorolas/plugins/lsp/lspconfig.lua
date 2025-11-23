return {
  "neovim/nvim-lspconfig",
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local server_dir = vim.fn.stdpath("config") .. "/lua/thorolas/plugins/lsp/servers"
    local files = vim.fn.globpath(server_dir, "*.lua", false, true)

    for _, file in ipairs(files) do
      local filename = vim.fn.fnamemodify(file, ":t:r")
      local ok, server = pcall(require, "thorolas.plugins.lsp.servers." .. filename)

      if ok and type(server) == "function"
        then server(capabilities)
        else vim.notify("Failed to load LSP server: " .. filename)
      end
    end

    local kw = require("thorolas.utility.keymaps")

    kw.group("<leader>g", "lsp")
    kw.command("<leader>gr", "lua vim.lsp.buf.rename()", "Rename")
    kw.command("<leader>gh", "lua vim.lsp.buf.hover()", "LSP Hover")
    kw.command("<leader>ga", "lua vim.lsp.buf.code_action()", "Code Action")
    kw.command("<leader>gf", "lua vim.lsp.buf.format({async = true})", "Format Document")
    kw.command("<leader>gd", "lua vim.diagnostic.open_float()", "Show Diagnostic")
    kw.command("<leader>gi", "lua vim.lsp.buf.implementation()", "Show Implementation")
    kw.command("<leader>gs", "lua vim.lsp.buf.document_symbol()", "Show Document Symbol")
    kw.command("<leader>gz", "lua vim.lsp.buf.references()", "Show References")
    kw.command("<leader>gc", "lua vim.lsp.buf.definition()", "Go To Definition")
  end,
}
