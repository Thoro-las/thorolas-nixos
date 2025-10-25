local kw = require("thorolas.utility.keymaps")

kw.group("<leader>c", "configuration")
kw.command("<leader>cn", "e /etc/nixos/", "Open NixOS Configuration")
kw.command("<leader>cc", "e /etc/nixos/modules/nvim/config/", "Open Neovim Configuration")
kw.command("<leader>cp", "e /etc/nixos/modules/nvim/config/lua/thorolas/plugins", "Open Plugins Configuration")
kw.command("<leader>cs", "e /etc/nixos/modules/nvim/config/lua/thorolas/snippets", "Open Snippets Configuration")
