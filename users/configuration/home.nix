{ users-loader, database, ... }:

users-loader.create-user {
  modules = [ "nvim" "firefox" ];
  scripts = [ "thrnix" ];
  packages = [
    database.pkgs.typst
  ];

  home-config = { config, pkgs, ... }: {
  };
}
