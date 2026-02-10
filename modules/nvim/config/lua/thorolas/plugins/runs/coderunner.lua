return {
  "CRAG666/code_runner.nvim",
  config = function()
    local function getrunners()
      local runners = {}

      local runners_dir = vim.fn.stdpath("config") .. "/lua/thorolas/plugins/runs/langs"
      local files = vim.fn.globpath(runners_dir, "*.lua", false, true)

      for _, file in ipairs(files) do
        local module = vim.fn.fnamemodify(file, ":t:r")
        local ok, config = pcall(require, "thorolas.plugins.runs.langs." .. module)

        if ok and type(config) == "table" then
          for lang, command in pairs(config) do
            runners[lang] = command;
          end
        end
      end

      return runners
    end

    require("code_runner").setup({
      filetype = getrunners(),
      mode = 'term',
      term = {
        position = "vert",
        size = 50,
      }
    })
  end
}
