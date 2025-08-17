return function(capabilities)
    require("lspconfig").lua_ls.setup({
        capabilities = capabilities,
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT", -- for Neovim
                },
                diagnostics = {
                    globals = { "vim" }, -- avoid "undefined global "vim"" warnings
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false, -- disable annoying popups
                },
                telemetry = {
                    enable = false,
                },
            },
        },
    })
end
