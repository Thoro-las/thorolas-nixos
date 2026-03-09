{ lib, ... }:

rec {
  fs = {
    list-subitems =
      folder: type:
      folder
      |> builtins.readDir
      |> lib.filterAttrs (_: file-type: file-type == type || type == "all")
      |> builtins.attrNames;
  };

  get-database =
    let
      to-placeholder-attrset =
        directory: type:
        fs.list-subitems directory type
        |> lib.map (module-name: { name = module-name; value = toString module-name; })
        |> lib.listToAttrs;
    in
    {
      modules =
        (to-placeholder-attrset ../modules "all")
        |> lib.mapAttrs' (name: value: { name = lib.removeSuffix ".nix" name; value = value; });
      scripts =
        (to-placeholder-attrset ../scripts "regular")
        |> lib.mapAttrs' (name: value: { name = lib.removeSuffix ".nix" name; value = value; });
    };
}
