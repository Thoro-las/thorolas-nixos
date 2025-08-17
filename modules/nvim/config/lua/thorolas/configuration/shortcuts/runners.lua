local kw = require("thorolas.utility.keymaps")
kw.group("<leader>r",  "runners")

kw.group("<leader>rt", "typst")
kw.command("<leader>rtt", "TypstWatch", "Start Typst Watch")
kw.command("<leader>rtp", "TypstPreview", "Start Typst Preview")
kw.command("<leader>rtu", "TypstPreviewUpdate", "Refresh Typst Preview")
kw.command("<leader>rts", "TypstPreviewStop", "Stop Typst Preview")

kw.group("<leader>rr", "coderunner")
kw.command("<leader>rrr", "RunCode", "Run The Current File")

kw.group("<leader>rp", "processing")
kw.command("<leader>rpr", "ProcessingRun", "Run Processing File")
kw.command("<leader>rpp", "ProdessingPresent", "Run Processing Present Mode")
kw.command("<leader>rpe", "ProcessingExport", "Export Processing Executable")

kw.group("<leader>re", "exercism")
kw.command("<leader>ret", "!exercism test", "Run Exercism Test")
kw.command("<leader>res", "!exercism submit", "Submit To Exercism")
