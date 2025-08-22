{ lib, pkgs, home-manager, ... }: 

let
  loader-utility = import ./loader-utility.nix { inherit home-manager lib pkgs; };
  available-modules = loader-utility.fs.list-subitems ../modules "directory";
in {
  load = module-names:
    let 
      dependencies = { inherit lib pkgs home-manager; };

      existing-modules = lib.filter 
        (module:
          builtins.elem module available-modules &&
          builtins.pathExists ../modules/${module}/setup.nix
        ) module-names;

      loaded-modules = lib.map 
        (module:
          let file = import ../modules/${module}/setup.nix dependencies;
          in { module = file.module; config = file.config; }
        ) existing-modules;
    in {
      programs = lib.pipe loaded-modules [
        (loaded-modules: lib.map ({module, config}: { 
            name = module.program;
            value = config; }) 
          loaded-modules)
        (loaded-programs: lib.listToAttrs loaded-programs)
        (loaded-programs: loaded-programs //
          { home-manager.enable = true; })
      ];

      aliases = lib.pipe loaded-modules [
        (loaded-modules: lib.map ({module, config}: module.aliases) loaded-modules)
        (aliases: lib.attrsets.mergeAttrsList aliases)
      ];

      sources = lib.pipe loaded-modules [
        (loaded-modules: lib.map ({module, config}: module.sources) loaded-modules)
        (aliases: lib.attrsets.mergeAttrsList aliases)
      ];

      packages = lib.lists.concatMap ({module, config}: 
                  module.packages) loaded-modules;
    };
}
