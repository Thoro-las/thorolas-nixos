return {
  "Aietes/esp32.nvim",
  opts = {
    build_dir = "build.custom",
    clangd_args = { "--query-driver=**", },
  },
  keys = {
    { "<leader>re", function() require("esp32").pick("monitor") end, desc = "ESP32: Pick & Monitor" },
  },
}
