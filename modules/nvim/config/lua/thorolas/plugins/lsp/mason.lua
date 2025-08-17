return {
    "williamboman/mason.nvim",
    dependencies = { "williamboman/mason-lspconfig.nvim", },

    build = ":MasonUpdate",
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({ automatic_installation = true, });

        local kw = require("thorolas.utility.keymaps")
        kw.command("<leader>m", "Mason", "Mason Explorer")
    end,
}
