return {
  "declancm/cinnamon.nvim",
  version = "*",
  enabled = false,
  config = function()
    require("cinnamon").setup {
      keymaps = {
        basic = true,
        extra = true,
      },

      options = { mode = "window" },
    }
  end
}
