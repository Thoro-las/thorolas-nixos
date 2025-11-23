return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup {
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 100,
        virt_text_pos = "eol",
      },
    }

    local kw = require("thorolas.utility.keymaps")
    kw.command("<leader>lg", "!kitty -e gitui &", "Show gitty UI")
  end
}
