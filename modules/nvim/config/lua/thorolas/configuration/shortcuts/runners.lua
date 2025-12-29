local kw = require("thorolas.utility.keymaps")
kw.group("<leader>r",  "runners")

kw.group("<leader>rt", "typst")
kw.command("<leader>rtt", "TypstWatch", "Start Typst Watch")
kw.command("<leader>rtp", "TypstPreview", "Start Typst Preview")
kw.command("<leader>rtu", "TypstPreviewUpdate", "Refresh Typst Preview")
kw.command("<leader>rts", "TypstPreviewStop", "Stop Typst Preview")

kw.group("<leader>rr", "coderunner")
kw.command("<leader>rrr", "RunCode", "Run The Current File")

kw.group("<leader>rs", "html server")
kw.command("<leader>rsr", "vsplit | terminal live-server", "Run Live-Server")
