return {
  "nvim-treesitter/nvim-treesitter",
  config = function()
    local tsconfig = require("nvim-treesitter.configs");
    tsconfig.setup({
      sync_installed = false,
      auto_install = true,

      indent = { enable = true },
      highlight = {
        enable = true,
        disable = function(_, buf)
          local max_filesize = 1024 * 1024
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then return true end
        end
      },

      rainbow = {
        enable = true,
        extended_mode = true,
      }
    });
  end
}
