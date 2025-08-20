{ users-loader, database, ... }:

users-loader.create-user {
  modules = [ "firefox" "nvim" ];
  scripts = [ "hergo" ];
  packages = with database.pkgs; [ typst tinymist ];

  home-config = { config, pkgs, ... }: {
  };
}
