{ lib, pkgs, home-manager, ... }: 

let
  loader-utility = import ./loader-utility.nix { inherit home-manager lib pkgs; };
  available-modules = loader-utility.fs.list-subitems ../modules "directory";
in {
  load = module-names:
    let 
      dependencies = { inherit lib pkgs home-manager; };

      check-exist = module:
        lib.lists.any module available-modules &&
        builtins.pathExists ../modules/${module}/setup.nix;

      existing-modules = lib.pipe module-names [
        (modules: lib.filter check-exist modules)
        (existing-modules: lib.map load-module existing-modules)
      ];

      load-module = name:
        let file = import ../${name}/setup.nix dependencies;
        in {
          module = file.module;
          config = file.config;
        };

      loaded-modules = lib.map load-module existing-modules;
      get-attribute = attribute: lib.lists.concatmap ({module, config}: 
                  module.${attribute};) loaded-modules;
    in {
      programs = lib.pipe loaded-modules [
        (loaded-modules: lib.map ({module, config}: { name = module.package; value = config; }) loaded-modules)
        (loaded-programs: lib.listToAttrs loaded-programs)
        (loaded-programs: loaded-programs // {home-manager.enable = true})
      ];

      aliases = get-attribute "aliases";
      sources = get-attribute "sources";
      packages = get-attribute "dependencies";
    };
}
