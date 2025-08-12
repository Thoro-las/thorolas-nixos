{ config, lib, pkgs, ... }: modules:

let
  database = import ./modules-database.nix;
  checkExist = program: lib.hasAttr "${program}" database;
  existing-modules = lib.filter checkExist program-names;
  unknown-modules = lib.filter (p: !checkExist p) program-names;

  warnings = [
    {
      assertion = lib.length unknown-modules == 0;
      message = "Warning: the following packages were not found:\n" +
                lib.strings.concatStringsSep "\n-" unknown-modules;
    }
  ];

  loaded-modules = lib.listToAttrs (lib.map (program: {
    name = database.${program}.package;
    value = {
      enable = true;
    };
  }) existing-modules);
in {
  warnings = warnings;
  modules = lib.recursiveUpdate loaded-modules {
    home-manager.enable = true;
  };
}
