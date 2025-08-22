{ users-loader, database, ... }:

users-loader.create-user {
  modules = [ "firefox" "nvim" ];
  scripts = [ ];
  packages = with database.pkgs; [ typst tinymist ];

  home-config = { config, pkgs, ... }: { };
}
