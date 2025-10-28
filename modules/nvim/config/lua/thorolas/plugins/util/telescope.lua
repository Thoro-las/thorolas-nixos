return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-project.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
  },

  config = function()
    local telescope = require("telescope")

    telescope.setup({
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },
        initial_mode = "normal"
      },

      mappings = {
        i = {
          ["<C-y>"] = function()
            local entry = require("telescope.actions.state").get_selected_entry()
            vim.fn.setreg("+", entry.text)
          end,
        }
      },

      extensions = {
        project = {
          patterns = {
            ".git",
            "_darcs",
            ".hg",
            ".bzr",
            ".svn",
            "Makefile",
            "package.json"
          },

          show_hidden = true,
          silent_chdir = false,
        },
      },
    })

    telescope.load_extension("file_browser")
    telescope.load_extension("project")


    local kw = require("thorolas.utility.keymaps")

    kw.group("<leader>f", "file")
    kw.command("<leader>ff", "Telescope find_files", "Find Files")
    kw.command("<leader>fo", "Telescope oldfiles", "Recent Files")
    kw.command("<leader>ft", "Telescope live_grep", "Search Text In Files");
    kw.command("<leader>fb", "Telescope file_browser path=%:p:h select_buffer=true", "Open File Browser");
    kw.command("<leader>fp", "Telescope project", "Show Projects");

    kw.group("<leader>s", "search")
    kw.command("<leader>sh", "Telescope help_tags", "Find Help")
    kw.command("<leader>sm", "Telescope man_pages", "Manual Pages")
    kw.command("<leader>sk", "Telescope keymaps", "Keymaps")
    kw.command("<leader>sc", "Telescope commands", "Commands")
  end,

}
