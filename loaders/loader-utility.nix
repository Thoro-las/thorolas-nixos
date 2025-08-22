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
}
