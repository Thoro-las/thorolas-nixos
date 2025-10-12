{ users-loader, database, ... }:

users-loader.create-user {
  modules = with database; [
    modules.nvim
    modules.design
    modules.socials
    modules.gaming
  ];

  scripts = [ ];
  packages = [ ];
}
