local kw = require("thorolas.utility.keymaps")

kw.group("<leader>q", "quit")
kw.command("<leader>bd", "bufdo bwipeout", "Close All Buffers")
kw.command("<leader>qq", "qall!", "Cancel & Quit All")

kw.command("<leader>w", "w!", "Force Write")
kw.command("<leader>x", "bdelete", "Kill Buffer")

kw.mapsnr("v", "<", "<gv", "Unindent Selection")
kw.mapsnr("v", ">", ">gv", "Indent Selection")
kw.mapsnr("v", "<a-j>", ":m '>+<CR>==gv", "Move Selection Down")
kw.mapsnr("v", "<a-k>", ":m '<-2<CR>==gv", "Move Selection Up")

kw.mapsnr("n", "<Esc>", "<cmd>nohlsearch<CR>", "Stop Search Highlight");

kw.mapd("n", "<leader>tt", function()
    local cwd = vim.fn.expand("%:p:h")
    vim.fn.jobstart({ "kitty" }, {
        cwd = cwd,
        detach = true,
    })
end, "Open Kitty")

kw.mapd("n", "<leader>ti", function()
    local cwd = vim.fn.expand("%:p:h")
    vim.fn.jobstart({ "kitty", "-e", "nvim" }, {
        cwd = cwd,
        detach = true,
    })
end, "Open NVIM Session")
