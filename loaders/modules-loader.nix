{ lib, pkgs, ... }: 

{
  load-programs = module-names:
    let
      database = import ./modules-database.nix;
      checkExist = module: lib.hasAttr "${module}" database;
      existing-modules = lib.filter checkExist module-names;
      loaded-modules = lib.listToAttrs (lib.map (module: 
        let
          loaded-module = database.${module};
          name = loaded-module;
          config-file = ./${module}/config.nix;
          extracted = if builtins.pathExists config-file;
            then (import config-file) // { enable = true; }
            else { enable = true; };
        in {
          name = name;
          value = extracted;
        }) existing-modules
      );
    in lib.recursiveUpdate loaded-modules
      { home-manager.enable = true; };
}
