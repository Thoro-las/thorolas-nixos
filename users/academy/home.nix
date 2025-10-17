{ users-loader, database, ... }:

users-loader.create-user {
  modules = [ "firefox" "nvim" "typing" "emulation" ];
}
