return {
    "windwp/nvim-autopairs",
    config = function()
        local pairs = require("nvim-autopairs");
        pairs.setup({
            disable_filetype = { "TelescopePrompt", "spectre_panel" },
            check_ts = true,
            ts_config = {
                lua = { "string", "source" },
                javascript = { "string", "template_string" },
                java = false,
            },

            fast_wrap = {
                map = "<M-e>",
                chars = { "{", "[", "(", "\'", "\"" },
                pattern = string.gsub([[ [%"%"%)%>%]%)%}%,] ]], "%s+", ""),
                offset = 0,

                end_key = "$",
                keys = "qwertyuiopzxcvbnmasdfghjkl",
                check_comma = true,
                highlight = "PmenuSel",
                highlight_grey = "LineNr",
            },
        });
    end
};
