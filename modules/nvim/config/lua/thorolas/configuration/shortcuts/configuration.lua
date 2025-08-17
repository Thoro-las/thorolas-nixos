local kw = require("thorolas.utility.keymaps")

kw.group("<leader>c", "configuration")
kw.command("<leader>cc", "e ~/.config/nvim", "Open Configuration")
kw.command("<leader>cp", "e ~/.config/nvim/lua/thorolas/plugins", "Open Plugins Configuration")
kw.command("<leader>cs", "e ~/.config/nvim/lua/thorolas/snippets", "Open Snippets Configuration")
