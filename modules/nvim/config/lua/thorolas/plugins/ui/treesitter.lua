return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        local tsconfig = require("nvim-treesitter.configs");
        tsconfig.setup({
            ensure_installed = {
                "lua",
                "python",
                "c",
                "cpp",
                "haskell"
            },

            sync_installed = false,
            auto_install = true,

            indent = { enable = true },
            highlight = {
                enable = true,
                disable = function(lang, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end
            },

            rainbow = {
                enable = true,
                extended_mode = true,
            }
        });
    end
}
