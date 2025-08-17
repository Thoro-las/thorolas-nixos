{ users-loader, ... }:

users-loader.create-user {
  modules = [ "nvim" ];
  scripts = [ "hergo" ];
  packages = [];

  home-config = { config, pkgs, ... }: {
    
  };
}
