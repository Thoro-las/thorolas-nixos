return {
  "nvim-java/nvim-java",
  config = function ()
    require("lspconfig").jdtls.setup({})
    require("java").setup({
      java_debug_adapter = {
        enable = true,
      },
    })
  end
}
