{ users-loader, database, ... }:

users-loader.create-user {
  modules = [ database.modules.nvim ];
  scripts = [ database.scripts.thrnix ];
  packages = [ ];
}
