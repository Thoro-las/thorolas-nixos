return {
	"kaarmu/typst.vim",
	dependencies = {
		"chomosuke/typst-preview.nvim",
	},
	lazy = false,
	version = "1.*",
	config = function()
		require("typst-preview").setup({})
	end
}
