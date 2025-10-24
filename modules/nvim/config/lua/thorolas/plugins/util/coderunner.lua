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
          local main_class = vim.fn.input("Main class (default Main): ", "Main")
          -- rm -rf build/*
          -- javac -d build src/*.java
          -- java -cp build Main
          --
          vim.fn.mkdir("build", "p")

          local compile = vim.fn.system("javac -d build src/*.java")
          if vim.v.shell_error ~= 0 then
            print("Compilation failed!")
            print(compile)
            return
          end

          return string.format("java -cp build $s", main_class)
        end
      },
      mode = 'term',
      term = {
        position = "vert",
        size = 50,
      }
    })


    vim.api.nvim_create_autocmd("TermClose", {
      callback = function()
        -- Instead of closing terminal window on exit,
        -- just switch terminal to normal mode and keep window open
        local bufnr = vim.api.nvim_get_current_buf()
        -- Do nothing or optionally send an Enter key to keep terminal open
        -- vim.api.nvim_input("<CR>")

        -- Another approach: do not close window, just leave terminal buffer open
        -- If you want, create a mapping to close manually later
      end,
    })
  end
}
