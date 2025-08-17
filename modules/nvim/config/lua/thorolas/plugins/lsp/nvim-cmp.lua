return {
    "hrsh7th/nvim-cmp",

    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "onsails/lspkind.nvim",

        "rafamadriz/friendly-snippets",
        "benfowler/telescope-luasnip.nvim"
    },

    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")
        local compare = require("cmp.config.compare")

        require("luasnip.loaders.from_vscode").lazy_load()
        pcall(require("telescope").load_extension, "luasnip")

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },

            mapping = cmp.mapping.preset.insert({
                ["<C-J>"] = cmp.mapping.select_next_item(),
                ["<C-K>"] = cmp.mapping.select_prev_item(),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
            }),

            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path" },
            }),

            formatting = {
                format = lspkind.cmp_format({
                    mode = "symbol_text",
                    maxwidth = 50
                }),
            },

            sorting = {
                priority_weight = 2,
                comparators = {
                    function(entry1, entry2)
                        local kind_priority = {
                            Field = 1,
                            Keyword = 2,
                            Variable = 3,
                            Function = 4,
                            Constant = 5,
                            Method = 6,
                            Struct = 7,
                            Class = 8,
                            Module = 9,
                            Text = 10,
                        }

                        local kind1 = entry1:get_kind()
                        local kind2 = entry2:get_kind()

                        local priority1 = kind_priority[cmp.lsp.CompletionItemKind[kind1]] or 100
                        local priority2 = kind_priority[cmp.lsp.CompletionItemKind[kind2]] or 100

                        if priority1 == priority2 then return nil end
                        return priority1 < priority2
                    end,

                    compare.offset,
                    compare.exact,
                    compare.score,
                    compare.recently_used,
                    compare.kind,
                    compare.sort_text,
                    compare.length,
                    compare.order,
                },
            }
        })

        -- Setup for command line completion
        cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" }
            }
        })

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" }
            }, {
                { name = "cmdline" }
            })
        })

        vim.keymap.set("n", "<leader>ss", "<cmd>Telescope luasnip<CR>", { desc = "Search snippets" })
    end,
}
