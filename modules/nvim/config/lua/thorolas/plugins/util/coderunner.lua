return {
  "CRAG666/code_runner.nvim",
  config = function()
    local function runcode()
      local current_file = vim.fn.expand("%")
      local project_root = vim.fn.getcwd()
      local fsproj_files = vim.fn.globpath(project_root, "*.fsproj", false, true)

      if #fsproj_files > 0 then
        return "dotnet run"
      else
        return "dotnet fsi " .. current_file
      end
    end

    require("code_runner").setup({
      filetype = {
        haskell = "runghc $file && exit",

        pde = function()
          local file = vim.fn.expand("%:p")
          local dir = vim.fn.fnamemodify(file, ":h")
          return "processing cli --sketch=" .. dir .. " --run"
        end,

        c = function()
          local filename = vim.fn.expand("%:t:r") -- filename without extension
          local file = vim.fn.expand("%")
          return string.format("gcc %s -o %s && ./%s", file, filename, filename)
        end,

        fsharp = runcode,
        fs = runcode,
        fsx = runcode,

        java = function()
          local main_file = ".main_class"
          local main_class = nil

          if vim.fn.filereadable(main_file) == 1 then
            main_class = vim.fn.readfile(main_file)[1]
          else
            main_class = vim.fn.input("Main class (default Main): ", "Main")
            vim.fn.writefile({ main_class }, main_file)
          end

          vim.fn.mkdir("build", "p")

          local jars = vim.fn.glob("lib/*.jar", 0, 1)
          local classpath = "build"
          if #jars > 0 then
            classpath = classpath .. ":" .. table.concat(jars, ":")
          end

          local compile_cmd = string.format("javac -cp %s -d build src/**/*.java", classpath)
          local compile = vim.fn.system(compile_cmd)
          if vim.v.shell_error ~= 0 then
            print("Compilation failed!")
            print(compile)
            return
          end

          return string.format("java -cp %s %s", classpath, main_class)
        end
      },
      mode = 'term',
      term = {
        position = "vert",
        size = 50,
      }
    })
  end
}
