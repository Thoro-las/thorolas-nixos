return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  lazy = false,

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    "3rd/image.nvim"
  },

  config = function()
    local filesystem_commands = require("neo-tree.sources.filesystem.commands")
    local wk = require("thorolas.utility/keymaps");
    wk.map("n", "<leader>e", "<cmd>Neotree toggle reveal=true<CR>", { desc = "Toggle Explorer" })

    local function trash(state)
      local node = state.tree:get_node()
      local path = node.path
      local name = node.name

      local answer = vim.fn.confirm("Trash " .. name .. "?", "&Yes\n&No", 2)
      if answer == 1 then
        vim.fn.jobstart({ "trash", path }, {
          detach = true,
          on_exit = function()
            filesystem_commands.refresh(state)
          end,
        })
      end
    end

    require("neo-tree").setup({
      filesystem = {
        filtered_items = {
          visible = false,
          show_hidden_count = false,
          hide_by_name = {
            "__pycache__",
          }
        },
        follow_current_file = {
          enable = true,
          leave_dirs_open = false
        },
        hijack_netrw_behavior = "open_default"
      },
      buffers = {
        follow_current_file = {
          enabled = true,           -- for buffer view
        },
      },
      git_status = {
        follow_current_file = {
          enabled = true,           -- for git view if needed
        },
      },
      window = {
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
          ["L"] = "set_root",
          ["H"] = "navigate_up",
          ["<space>"] = "noop",
          ["."] = "toggle_hidden",
          ["<C-D>"] = "delete",
          ["d"] = trash,
          ["o"] = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            local open_cmd = ({
              Darwin     = "open",
              Linux      = "xdg-open",
              Windows_NT = "explorer"
            })[vim.loop.os_uname().sysname] or "xdg-open"

            vim.fn.jobstart({ open_cmd, path }, { detach = true })
          end,
        }
      }
    });
  end
}
