return {
  "mistricky/codesnap.nvim",
  build = "make",
  config = function()
    require("codesnap").setup({
      watermark = "",
      bg_padding = 10
    })
  end
}
