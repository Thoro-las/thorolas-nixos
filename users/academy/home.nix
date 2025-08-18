{ users-loader, ... }:

users-loader.create-user {
  modules = [ "firefox" "nvim" ];
  scripts = [ ];
  packages = [];

  home-config = { config, pkgs, ... }: {
    
  };
}
