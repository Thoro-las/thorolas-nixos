return {
  "CRAG666/code_runner.nvim",
  config = function()
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
        sage = function()
          local current_file = vim.fn.expand("%")
          return string.format("sage %s", current_file)
        end,

        arduino = function()
          local file = vim.fn.expand("%:p")
          local dir = vim.fn.fnamemodify(file, ":h")
          return "processing-java --sketch=" .. dir .. " --run"
        end,

        c = function()
          local filename = vim.fn.expand("%:t:r")
          local file = vim.fn.expand("%")
          return string.format("gcc %s -o %s -lm && ./%s", file, filename, filename)
        end,

        fsharp = run_fsharp,
        fs = run_fsharp,
        fsx = run_fsharp,



        java = function()
          local main_file = ".main_class"
          local cwd = vim.fn.getcwd()
          local buf = vim.api.nvim_buf_get_name(0)

          --------------------------------------------------------------------
          -- Detect single-file mode
          --------------------------------------------------------------------
          local is_java_file = buf:match("%.java$") ~= nil
          local has_pom = vim.fn.filereadable(cwd .. "/pom.xml") == 1
          local has_src = vim.fn.isdirectory(cwd .. "/src") == 1

          -- If no project layout and editing a single .java file → script mode
          if is_java_file and not has_pom and not has_src then
            local filename = vim.fn.fnamemodify(buf, ":t")
            local classname = filename:gsub("%.java$", "")

            -- Temporary directory
            local tmp = cwd .. "/.java_tmp"
            vim.fn.mkdir(tmp, "p")

            -- Compile
            local compile_cmd = string.format(
              "javac -d %s %s",
              tmp,
              vim.fn.fnameescape(buf)
            )
            local compile_output = vim.fn.system(compile_cmd)

            if vim.v.shell_error ~= 0 then
              print("Compilation failed!\n" .. compile_output)
              return
            end

            -- Run
            local run_cmd = string.format("java -cp %s %s", tmp, classname)

            -- Clean temp folder AFTER program finishes
            return string.format('bash -c "%s; rm -rf %s"', run_cmd, tmp)
          end

          --------------------------------------------------------------------
          -- NORMAL PROJECT MODE (your original code)
          --------------------------------------------------------------------

          local main_class
          if vim.fn.filereadable(main_file) == 1 then
            main_class = vim.fn.readfile(main_file)[1]
          else
            main_class = vim.fn.input("Main class (fully-qualified): ", "Main")
            vim.fn.writefile({ main_class }, main_file)
          end

          local pom_path = cwd .. "/pom.xml"

          if has_pom then
            return string.format(
              'bash -c "mvn -q compile && mvn -q exec:java -Dexec.mainClass=%s"',
              main_class
            )
          else
            vim.fn.mkdir("build", "p")

            -- Jars in lib/
            local jars = vim.fn.globpath("lib", "*.jar", false, true)
            local sep = package.config:sub(1, 1) == "\\" and ";" or ":"

            -- Classpath
            local classpath = "build"
            if #jars > 0 then
              classpath = classpath .. sep .. table.concat(jars, sep)
            end

            -- Java files
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
