vim.api.nvim_create_autocmd("User", {
  pattern = "AlphaReady",
  callback = function()
    vim.cmd("set laststatus=0")
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  once = true,
  callback = function()
    if vim.fn.argc() == 0 and vim.fn.bufname() == "" and vim.bo.filetype == "" then
      vim.cmd("Alpha")
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "gleam",
    callback = function()
        vim.bo.tabstop = 2
        vim.bo.shiftwidth = 2
        vim.bo.softtabstop = 2
        vim.bo.expandtab = true
    end,
})
