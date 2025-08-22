{ users-loader, ... }:

users-loader.create-user {
  modules = [ "ftube" ];
  scripts = [ ];
  packages = [];

  home-config = { config, pkgs, ... }: {
    
  };
}
