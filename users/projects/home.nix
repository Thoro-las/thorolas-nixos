{ users-loader, ... }:

users-loader.create-user {
  modules = [ "design" ];
  scripts = [ ];
  packages = [];

  home-config = { config, pkgs, ... }: {
    
  };
}
