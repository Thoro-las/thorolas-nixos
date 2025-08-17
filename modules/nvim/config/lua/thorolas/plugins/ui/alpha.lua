return {
    "goolord/alpha-nvim",
    config = function()
        local dashboard = require("alpha.themes.dashboard");

        dashboard.section.header.val = {
            [[┌───────────────────────────────────────────────────────────────────────┐]],
            [[│    _________  ________  ________  ___   _______  ______ ______        │]],
            [[│   |\   ___  \|\  _____\|\   __  \|\  \  |  |\  \|\     \|     \       │]],
            [[│   \.\  \\.\  \.\  \___|\.\  \ \  \.\  \ |  |.\  \.\  \\___\.\  \      │]],
            [[│    \.\  \\.\  \.\   ____\.\  \ \  \.\  \|  |\.\  \.\  \___|\.\  \     │]],
            [[│     \.\  \\.\  \.\  \___|\.\  \_\  \.\     | \.\  \.\  \    \.\  \    │]],
            [[│      \.\__\\.\__\.\_______\.\_______\.\____|  \.\__\.\__\    \.\__\   │]],
            [[│       \|__| \|__|\|_______|\|_______|\|____|   \|__|\|__|     \|__|   │]],
            [[│                                                                       │]],
            [[└───────────────────────────────────────────────────────────────────────┘]],
        };

        dashboard.section.buttons.val = {
            dashboard.button("<leader>fp", "󱃐   Recent Projects", "<cmd>Telescope project<CR>"),
            dashboard.button("<leader>fb", "󱃐   File Browser", "<cmd>Telescope file_browser<CR>"),
            dashboard.button("<leader>fo", "󱋡   Recent Files", "<cmd>Telescope oldfiles<CR>"),
            dashboard.button("<leader>ff", "󰱼   Find Files", "<cmd>Telescope oldfiles<CR>"),
            dashboard.button("<leader>cc", "   Configuration", ":e ~/.config/nvim/<CR>"),
            dashboard.button("<leader>qq", "󰤆   Quit Neovim", "<cmd>qa<CR>")
        };

        dashboard.section.footer.val = function()
            return "Its all okay";
        end

        dashboard.section.footer.opts.hl = "Type";
        dashboard.section.header.opts.hl = "Include";
        dashboard.section.buttons.opts.hl = "Keyword";

        dashboard.opts.opts.noautocmd = true;
        require("alpha").setup(dashboard.opts);

        local function show_alpha_if_last_buffer()
            local bufs = vim.fn.getbufinfo({ buflisted = 1 })
            if #bufs == 1 and bufs[1].name == "" then
                require("alpha").start(true)
            end
        end

        vim.api.nvim_create_autocmd("BufDelete", {
            callback = function()
                vim.defer_fn(function()
                    show_alpha_if_last_buffer()
                end, 50)
            end,
        })
    end
};
