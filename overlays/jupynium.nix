final: prev: {
  vimPlugins = prev.vimPlugins // {
    jupynium = prev.vimUtils.buildVimPlugin {
      pname = "jupynium";
      version = "2024-02-10";

      src = prev.fetchFromGitHub {
        owner = "kiyoon";
        repo = "jupynium.nvim";
        rev = "HEAD";
        hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
      };

      meta = {
        description = "Neovim plugin for live Jupyter notebook interaction";
        homepage = "https://github.com/kiyoon/jupynium.nvim";
        license = prev.lib.licenses.mit;
      };
    };
  };
}
