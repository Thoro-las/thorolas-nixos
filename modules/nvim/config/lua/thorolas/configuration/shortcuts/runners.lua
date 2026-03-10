local kw = require("thorolas.utility.keymaps")
kw.group("<leader>r",  "runners")

kw.group("<leader>rt", "typst")
kw.command("<leader>rtt", "TypstWatch", "Start Typst Watch")
kw.command("<leader>rtp", "TypstPreview", "Start Typst Preview")
kw.command("<leader>rtu", "TypstPreviewUpdate", "Refresh Typst Preview")
kw.command("<leader>rts", "TypstPreviewStop", "Stop Typst Preview")

kw.group("<leader>rq", "quarto")
kw.command("<leader>rqq", "QuartoPreview", "Start Quarto Watch")

kw.group("<leader>rr", "coderunner")
kw.command("<leader>rrr", "RunCode", "Run The Current File")

kw.group("<leader>rs", "html server")
kw.command("<leader>rsr", "vsplit | terminal live-server", "Run Live-Server")

local function findmake(path)
  local makefile = vim.fs.find("Makefile", { path = path, upward = true })[1]
  if makefile then return vim.fs.dirname(makefile) end
end

vim.api.nvim_create_user_command("RunMake", function(options)
  local currentfile = vim.api.nvim_buf_get_name(0)
  local makedirectory = findmake(vim.fs.dirname(currentfile))

  if makedirectory then
    vim.notify("Makefile found at: " .. makedirectory, vim.log.levels.INFO)
    local target = options.args ~= "" and options.args or ""
    vim.cmd("lcd " .. makedirectory)
    vim.cmd("term make " .. target)
  else
    vim.notify("No Makefile was found", vim.log.levels.WARN)
  end
end, {})


kw.group("<leader>rm", "make")
kw.command("<leader>rmm", "RunMake", "Run Makefile Targetless")
