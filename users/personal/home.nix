{ users-loader, ... }:

users-loader.create-user {
  modules = [ "nvim" "steam" ];
  scripts = [ ];
  packages = [];

  home-config = { config, pkgs, ... }: {
  };
}
