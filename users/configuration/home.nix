{ users-loader, database, ... }:

users-loader.create-user {
  modules = [ "nvim" "firefox" "design" ];
  scripts = [ "thrnix" ];
  packages = [ ];

  home-config = { config, pkgs, ... }: {
  };
}
