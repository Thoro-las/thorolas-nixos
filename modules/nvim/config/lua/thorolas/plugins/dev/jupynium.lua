return {
  "kiyoon/jupynium.nvim",
  dependencies = {
    "rcarriga/nvim-notify",
    "stevearc/dressing.nvim",
  },
  config = function()
    require("jupynium").setup({
      python_host = "/home/main/.nix-profile/bin/python3",
      default_notebook_URL = "localhost:8888/nbclassic",
    })
  end
}
