return {
  "flashcodes-themayankjha/fkthemes.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-telescope/telescope.nvim",

    "neanias/everforest-nvim",
  },
  config = function()
    require("fkthemes").setup({
      themes = { "everforest" },
      default_theme = "everforest",
      transparent_background = true,
    })
  end,
}
