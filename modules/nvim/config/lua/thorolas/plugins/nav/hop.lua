return {
  "phaazon/hop.nvim",
  config = function()
    require("hop").setup({ keys = "etovxqpdygfblzhckisuran", term_seq_bias = 0.5 });

    local kw = require("thorolas.utility.keymaps")
    kw.mapd({ "n", "s", "x" }, "f", ":HopChar1<CR>", "Hop To Character")
    kw.mapnr("n", "t", ":HopPattern<CR>", "Hop To Pattern");
  end
};
