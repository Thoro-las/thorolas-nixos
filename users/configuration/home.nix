{ users-loader, database, ... }:

users-loader.create-user {
  modules = [ "nvim" "firefox" "steam" ];
  scripts = [ "thrnix" ];
  packages = [ ];

  home-config = { config, pkgs, ... }: {
  };
}
