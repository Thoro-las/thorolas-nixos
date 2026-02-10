return {
  c = function()
    local filename = vim.fn.expand("%:t:r")
    local file = vim.fn.expand("%")
    return string.format("g++ %s -o %s -lm && ./%s", file, filename, filename)
  end,
}
