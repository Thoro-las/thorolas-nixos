return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("todo-comments").setup()

        local kw = require("thorolas.utility.keymaps")
        kw.command("<leader>tl", "TodoTelescope", "Show Todos")
    end
}
