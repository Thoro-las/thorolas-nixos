{ users-loader, ... }:

users-loader.create-user {
  modules = [ "nvim" ];
  scripts = [ ];
  packages = [];

  home-config = { config, pkgs, ... }: {
  };
}
