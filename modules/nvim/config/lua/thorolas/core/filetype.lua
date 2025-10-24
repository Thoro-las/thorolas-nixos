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

vim.api.nvim_create_user_command('JavaRun', function()
  vim.cmd('!javac -d build src/*.java')
  vim.cmd('!java -cp build Main')
end, {})
