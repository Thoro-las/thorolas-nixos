{ users-loader, ... }:

users-loader.create-user {
  modules = [ "nvim" "firefox" ];
  scripts = [ "hergo" "hego" "thrnix" ];
  packages = [];

  home-config = { config, pkgs, ... }: {
  };
}
