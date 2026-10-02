return {
  "goolord/alpha-nvim",
  config = function()
    local dashboard = require("alpha.themes.dashboard");
    dashboard.opts.opts.noautocmd = true;

    dashboard.section.header.val = {
      [[                                                                ]],
      [[                █████                                         ]],
      [[       █████  █████          ████  ████                    ]],
      [[      ██████ █████            ████ ████                    ]],
      [[     ██████████████████████████████ ███ ████████████  ]],
      [[    ████████████████    █████████████ ███ ████▀███▀████  ]],
      [[   █████████████████████ █████████ ███ ████ ███ ████  ]],
      [[  ████ ██████████    ███ █████████ ███ ████ ███ ████  ]],
      [[ ████  █████████████ █████████ █████ ███ ████ ███ ████  ]],
      [[                                                                ]],
    };

    dashboard.section.buttons.val = { };
    dashboard.section.footer.val = {
      [[When Krylov asks if Ax = b]],
      [[ but K = { e | U(e,e) ↓ }]],
    };

    dashboard.section.header.opts.hl = "String";
    dashboard.section.buttons.opts.hl = "Keyword";
    dashboard.section.footer.opts.hl = "Type";

    dashboard.opts.layout[1].val = function()
      local contentheight = #dashboard.section.header.val + #dashboard.section.footer.val
      return vim.fn.floor((vim.fn.winheight(0) - contentheight - 2) / 2)
    end

    table.insert(dashboard.opts.layout, {
      type = "padding",
      val = function()
        local contentheight = #dashboard.section.header.val + #dashboard.section.footer.val
        return vim.fn.floor((vim.fn.winheight(0) - contentheight - 2) / 2)
      end
    })

    require("alpha").setup(dashboard.opts);
  end
};
