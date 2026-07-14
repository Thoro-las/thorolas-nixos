return {
  cpp = function()
    local file = vim.fn.expand("%")
    local exe = vim.fn.tempname()

    return string.format(
      "g++ -std=c++20 -Wall -Wextra %s -o %s && %s",
      vim.fn.shellescape(file),
      vim.fn.shellescape(exe),
      vim.fn.shellescape(exe)
    )
  end,
}
