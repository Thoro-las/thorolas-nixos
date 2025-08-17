return {
    "jiaoshijie/undotree",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local undotree = require("undotree")

        undotree.setup({
            float_diff = true,
            layout = "left_bottom",
            ignore_filetype = { "Undotree", "UndotreeDiff", "qf", "TelescopePrompt", "spectre_panel", "tsplayground" },
            window = {
                winblend = 30,
            },
            keymaps = {
                ["j"] = "move_next",
                ["k"] = "move_prev",
                ["J"] = "move_change_next",
                ["K"] = "move_change_prev",
                ["<cr>"] = "action_enter",
                ["p"] = "enter_diffbuf",
                ["q"] = "quit",
            },
        })
    end
};
