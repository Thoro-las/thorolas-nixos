return {
  'neet-007/rfc-view.nvim',
  branch = 'master',
  build = 'cd go && go build main.go',
  config = function()
    require('rfcview').setup {
      delete_buffers_when_closing = true,
    }
  end,
  keys = {
    {
      '<leader>ro',
      function()
        require('rfcview').open_rfc()
      end,
      desc = '[R]FC [O]pen Main Window',
    },
    {
      '<leader>rc',
      function()
        require('rfcview').close_rfc()
      end,
      desc = '[R]FC [C]lose All Windows',
    },
  },
}
