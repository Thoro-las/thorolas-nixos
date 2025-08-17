return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("bufferline").setup({
            options = {
                mode = "buffers",
                show_close_icon = false,
                show_buffer_close_icons = false,
                separator_style = "slant",
                enforce_regular_tabs = true,
                always_show_bufferline = true,

                custom_filter = function(buf_number, buf_numbers)
                    local ft = vim.bo[buf_number].filetype
                    local bt = vim.bo[buf_number].buftype
                    local name = vim.fn.bufname(buf_number)

                    -- Exclude these from bufferline
                    if ft == "qf" or bt == "nofile" or name == "messages" then
                        return false
                    end

                    return true
                end
            },
        })

        local kw = require("thorolas.utility.keymaps")

        kw.group("<leader>b", "buffer")
        kw.command("<leader>bb", "Telescope buffers", "Show Buffers")
        kw.command("<leader>bn", "tabnext", "Next Buffer")
        kw.command("<leader>bp", "tabprevious", "Previous Buffer")
    end,
}
