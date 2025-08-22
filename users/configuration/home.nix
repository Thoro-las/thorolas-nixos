{ users-loader, database, ... }:

users-loader.create-user {
  modules = [ "nvim" "firefox" ];
  scripts = [ "hergo" "hego" "thrnix" ];
  packages = [
    database.pkgs.typst
  ];

  home-config = { config, pkgs, ... }: {
  };
}
