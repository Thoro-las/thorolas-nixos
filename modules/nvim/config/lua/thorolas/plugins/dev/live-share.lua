return {
  "azratul/live-share.nvim",
  dependencies = {
    "jbyuki/instant.nvim",
  },
  config = function()
    vim.g.instant_username = "thorolas"
    require("live-share").setup({
      port_internal = 8765,
      max_attempts = 40,
      service = "serveo.net"
    })
  end
}
