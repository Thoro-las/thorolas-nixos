{ users-loader, database, ... }:

users-loader.create-user {
  modules = [ "nvim" ];
  scripts = [ "thrnix" ];
  packages = [ ];
}
