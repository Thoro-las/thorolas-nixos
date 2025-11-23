return {
  '2kabhishek/nerdy.nvim',
  cmd = 'Nerdy',
  dependencies = { 'folke/snacks.nvim', },
  config = function()
    require("nerdy").setup({
      max_recents = 30,
      add_default_keybindings = true,
      use_new_command = true,
    })

    local kw = require("thorolas.utility.keymaps")

    kw.command("<leader>ln", "Nerdy", "Nerdy Show List")
  end,
}
