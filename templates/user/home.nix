{ users-loader, database, ... }:

users-loader.create-user {
  modules = [ ];
  scripts = [ ];
  packages = [ ];

  home-config = { config, pkgs, ... }: {
  };
}
