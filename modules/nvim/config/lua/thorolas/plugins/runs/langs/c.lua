return {
  c = function()
    local file = vim.fn.expand("%:p")
    local exe  = vim.fn.expand("%:p:r")

    local cmd  = string.format(
      'gcc "%s" -lm -o "%s" && "%s" && rm -f "%s"',
      file,
      exe,
      exe,
      exe
    )

    vim.notify(cmd)
    return cmd
  end
}
