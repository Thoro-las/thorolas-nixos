{ pkgs, lib, ... }:

{
  list-subitems = folder: type:
    lib.pipe folder [
      (dir: builtins.readDir dir)
      (subitems: lib.filterAttrs (_: type: type == type) subitems)
      (subitems: builtins.attrNames subitems)
    ];

  generate-password = user:
    user;

  generate-description = user:
    if user != ""
      then 
        (lib.strings.toUpper (builtins.substring 0 1 user)) + 
        (builtins.substring 1 ((builtins.stringLength user) - 1) user)
      else "";

  generate-home = user:
    "/home/" + user;

  generate-home-config = user:
    "../users/${user}/home.nix";
}
