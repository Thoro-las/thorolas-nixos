{ users-loader, ... }:

users-loader.create-user {
  modules = [ "ftube" ];
  scripts = [ "hergo" ];
  packages = [];
};
