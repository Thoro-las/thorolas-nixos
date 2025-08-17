return {
    "folke/which-key.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "echasnovski/mini.icons" },
    config = function()
        local setup = {
            plugins = {
                marks = true,
                registers = true,
                spelling = {
                    enabled = true,
                    suggestions = 10,
                },
                presets = {
                    operators = false,
                    motions = true,
                    text_objects = true,
                    windows = true,
                    nav = true,
                    z = true,
                    g = true,
                },
            },
            icons = {
                breadcrumb = "»",
                separator = "➜",
                group = "+",
            },
            layout = {
                height = { min = 4, max = 25 },
                width = { min = 20, max = 50 },
                spacing = 3,
                align = "left",
            },
            show_help = true,
        };

        local whichkey = require("which-key");
        whichkey.setup(setup)
    end
}
