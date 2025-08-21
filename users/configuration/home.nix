{ users-loader, database, ... }:

users-loader.create-user {
  modules = [ "nvim" "firefox" ];
  scripts = [ "hergo" "hego" "thrnix" ];
  packages = [
    database.pkgs.typst
    database.custom-pkgs.typst-lsp
  ];

  home-config = { config, pkgs, ... }: {
  };
}
