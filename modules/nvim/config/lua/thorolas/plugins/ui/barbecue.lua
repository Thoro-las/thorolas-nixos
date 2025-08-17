-- plugins/ui/barbecue.lua
return {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons", -- optional
    },
    config = function()
        require("barbecue").setup({
            attach_navic = true,
            theme = "auto",
            show_modified = true,
        })
    end,
}
