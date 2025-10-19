return {
  "nvim-java/nvim-java",
  dependencies = {
    "nvim-java/lua-async-await",
    "nvim-java/nvim-java-core",
    "nvim-java/nvim-java-test",
    "nvim-java/nvim-java-dap",
    "nvim-java/nvim-java-refactor",
    "nvim-java/nvim-java-runner",
    "mfussenegger/nvim-dap",
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("java").setup()
  end,
}
