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

    local function run_python()
      local current_file = vim.fn.expand("%")
      local project_root = vim.fn.getcwd()
      local env_file = project_root .. "/.env"
      
      if vim.fn.filereadable(env_file) == 1 then
        return string.format("%s/bin/python3 %s", env_file, current_file)
      else
        return "python3 " .. current_file
      end
    end

    require("code_runner").setup({
      filetype = {
        python = run_python,
        haskell = "runghc $file && exit",
        pde = function()
          local file = vim.fn.expand("%:p")
          local dir = vim.fn.fnamemodify(file, ":h")
          return "processing cli --sketch=" .. dir .. " --run"
        end,
        c = function()
          local filename = vim.fn.expand("%:t:r")
          local file = vim.fn.expand("%")
          return string.format("gcc %s -o %s && ./%s", file, filename, filename)
        end,
        fsharp = runcode,
        fs = runcode,
        fsx = runcode,
        java = function()
          local main_file = ".main_class"
          local main_class
          if vim.fn.filereadable(main_file) == 1 then
            main_class = vim.fn.readfile(main_file)[1]
          else
            main_class = vim.fn.input("Main class (default Main): ", "Main")
            vim.fn.writefile({ main_class }, main_file)
          end

          vim.fn.mkdir("build", "p")

          -- Get jars in lib/
          local jars = vim.fn.globpath("lib", "*.jar", false, true)
          local sep = package.config:sub(1, 1) == "\\" and ";" or ":"

          -- Build classpath string
          local classpath = "build"
          if #jars > 0 then
            classpath = classpath .. sep .. table.concat(jars, sep)
          end

          -- Get all Java files recursively in src/
          local java_files = vim.fn.glob("src/**/*.java", 1, 1)
          local java_list = table.concat(java_files, " ")

          -- Compile
          local compile_cmd = string.format("javac -cp %s -d build %s", classpath, java_list)
          local compile = vim.fn.system(compile_cmd)
          if vim.v.shell_error ~= 0 then
            print("Compilation failed!\n" .. compile)
            return
          end

          -- Run
          local run_cmd = string.format("java -cp %s %s", classpath, main_class)
          return run_cmd
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
