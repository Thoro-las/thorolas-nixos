return {
  'GCBallesteros/jupytext.nvim',
  dependencies = {
    'hkupty/iron.nvim',
    'kana/vim-textobj-user',
    'kana/vim-textobj-line',
    'GCBallesteros/vim-textobj-hydrogen',
  },
  version = '0.2.0',
  config = function()
    require("jupytext").setup({
      style = "hydrogen",
      output_extension = "py",
    })
  end
}
