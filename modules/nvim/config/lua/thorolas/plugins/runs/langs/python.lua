return {
  python = function()
    local current_file = vim.fn.expand("%")
    local project_root = vim.fn.getcwd()
    local env_file = project_root .. "/.env"

    if vim.fn.filereadable(env_file) == 1 then
      return string.format("%s/bin/python3 %s", env_file, current_file)
    else
      return "python3 " .. current_file
    end
  end
}
