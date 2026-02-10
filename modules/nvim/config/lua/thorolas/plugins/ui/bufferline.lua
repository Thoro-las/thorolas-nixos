return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("bufferline").setup({
      options = {
        mode = "buffers",
        show_close_icon = true,
        show_buffer_close_icons = true,
        always_show_bufferline = true,
      },
    })

    local kw = require("thorolas.utility.keymaps")

    kw.group("<leader>b", "buffer")
    kw.command("<leader>bb", "Telescope buffers", "Show Buffers")
    kw.command("<leader>bn", "tabnext", "Next Buffer")
    kw.command("<leader>bp", "tabprevious", "Previous Buffer")
  end,
}
