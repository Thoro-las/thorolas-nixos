return {
  "declancm/cinnamon.nvim",
  version = "*",
  enabled = true,
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
