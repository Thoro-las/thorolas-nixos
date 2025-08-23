{ pkgs, lib, ... }:

rec {
  fs = {
    list-subitems = folder: type:
      lib.pipe folder [
        (dir: builtins.readDir dir)
        (subitems: lib.filterAttrs (_: file-type: file-type == type) subitems)
        (subitems: builtins.attrNames subitems)
      ];
  };

  create-database = let
    to-useless-attrset = directory: type: 
      lib.pipe fs.list-subitems directory type [
        (module-names: lib.map
          (module-name: { name = module-name; value = "" + module-name; })
          module-names)
        (module-names: lib.listToAttrs module-names)
      ];
  in {
    modules = to-useless-attrset ../modules "directory";
    scripts = to-useless-attrset ../scripts "regular";
  };
}
