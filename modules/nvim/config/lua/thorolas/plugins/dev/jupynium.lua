return {
  -- {
  --   "kiyoon/jupynium.nvim",
  --   dependencies = {
  --     "rcarriga/nvim-notify",
  --     "stevearc/dressing.nvim",
  --   },
  --   config = function()
  --     require("jupynium").setup({
  --       python_host = "/home/main/.nix-profile/bin/python3",
  --       default_notebook_URL = "localhost:8888/nbclassic",
  --     })
  --   end
  -- },

  {
    "GCBallesteros/NotebookNavigator.nvim",
    keys = {
      { "<leader>j", function() require("notebook-navigator").move_cell "d" end },
      { "<leader>k", function() require("notebook-navigator").move_cell "u" end },
      { "<leader>X", "<cmd>lua require('notebook-navigator').run_cell()<cr>" },
      { "<leader>x", "<cmd>lua require('notebook-navigator').run_and_move()<cr>" },
    },

    dependencies = {
      "echasnovski/mini.comment",
      "hkupty/iron.nvim",
      "anuvyklack/hydra.nvim",
    },

    config = function()
      require("notebook-navigator").setup({})
    end,
  }
}
