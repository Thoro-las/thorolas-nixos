return {
  "williamboman/mason.nvim",
  dependencies = { "williamboman/mason-lspconfig.nvim", },

  build = ":MasonUpdate",
  config = function()
    require("mason").setup({
      registries = {
        "github:mason-org/mason-registry",
      },
      providers = {
        "mason.providers.registry-api",
        "mason.providers.client",
      },
    })
    require("mason-lspconfig").setup({ automatic_installation = true, });

    local kw = require("thorolas.utility.keymaps")
    kw.command("<leader>m", "Mason", "Mason Explorer")
  end,
}
