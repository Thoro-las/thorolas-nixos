{
  lib,
  pkgs,
  home-manager,
  ...
}:

let
  loader-utility = import ./loader-utility.nix { inherit home-manager lib pkgs; };
  available-modules = loader-utility.fs.list-subitems ../modules "all";
in
{
  load =
    dependencies: module-names:
    let
      existing-modules = lib.filter (
        module:
        builtins.elem module available-modules && (
           builtins.pathExists ../modules/${module}/setup.nix 
        || builtins.pathExists ../modules/${module})
      ) module-names;

      loaded-modules = 
        existing-modules 
        |> lib.map (module:
          let
            file =
              if lib.strings.hasSuffix ".nix" module 
                then import ../modules/${module} dependencies
                else import ../modules/${module}/setup.nix dependencies;
          in {
            module = file.module;
            config = file.config or { enable = true; };
          }
        );
    in
    {
      programs =
        loaded-modules
        |> lib.filter ({ module, config }: module ? program)
        |> lib.map ( { module, config }: { name = module.program; value = config; })
        |> lib.listToAttrs
        |> (loaded-programs: loaded-programs // { home-manager.enable = true; });

      aliases = 
        loaded-modules
        |> lib.map ({ module, config }: module.aliases or { })
        |> lib.attrsets.mergeAttrsList;

      sources =
        loaded-modules
        |> lib.map ({ module, config }: module.sources or { })
        |> lib.attrsets.mergeAttrsList;

      packages = lib.lists.concatMap ({ module, config }: module.packages or [ ]) loaded-modules;
    };
}
