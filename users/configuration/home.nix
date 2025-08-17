{ users-loader, ... }:

users-loader.create-user {
  modules = [ "nvim" ];
  scripts = [ "hergo" "hego" ];
  packages = [];

  home-config = { config, pkgs, ... }: {

  };
}
