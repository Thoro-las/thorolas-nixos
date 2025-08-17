{ users-loader, ... }:

users-loader.create-user {
  modules = [ "htop" ];
  scripts = [ "hergo" "hego" ];
  packages = [];

  home-config = { config, pkgs, ... }: {

  };
}
