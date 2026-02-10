local function run_fsharp()
  local current_file = vim.fn.expand("%")
  local project_root = vim.fn.getcwd()
  local fsproj_files = vim.fn.globpath(project_root, "*.fsproj", false, true)

  if #fsproj_files > 0 then
    return "dotnet run"
  else
    return "dotnet fsi " .. current_file
  end
end

return {
  fsharp = run_fsharp,
  fs = run_fsharp,

  fsx = "dotnet fsi %filePath",
}
