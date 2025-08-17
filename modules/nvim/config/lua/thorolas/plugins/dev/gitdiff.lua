return {
    "sindrets/diffview.nvim",
    config = function()
        require("diffview").setup()

        local kw = require("thorolas.utility.keymaps")
        kw.command("<leader>ld", "DiffviewOpen", "Open Git Diff-View")
    end
}
