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

  get-database =
    let
      to-placeholder-attrset = directory: type:
        lib.pipe (fs.list-subitems directory type) [
          (module-names: lib.map
            (module-name: { name = module-name; value = "" + module-name; })
            module-names)
          (module-names: lib.listToAttrs module-names)
        ];
    in
    {
      modules = to-placeholder-attrset ../modules "directory";
      scripts = lib.pipe (to-placeholder-attrset ../scripts "regular") [
        (script-names: lib.mapAttrs'
          (name: value: {
            name = lib.removeSuffix ".nix" name;
            value = value;
          })
          script-names)
      ];
    };
}
