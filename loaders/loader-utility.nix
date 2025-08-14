{ pkgs, lib, ... }:

{
  fs = {
    list-subitems = folder: type:
      lib.pipe folder [
        (dir: builtins.readDir dir)
        (subitems: lib.filterAttrs (_: file-type: file-type == type) subitems)
        (subitems: builtins.attrNames subitems)
      ];
  };

  generators = {
    get-password = user:
      user;

    get-description = user:
      if user == "" then "" else 
        (lib.strings.toUpper (builtins.substring 0 1 user)) +
        (builtins.substring 1 ((builtins.stringLength user) - 1) user);

    get-home = user:
      "/home/" + user;

    get-homeconfig = user:
      "../users/${user}/home.nix";
  };
}
