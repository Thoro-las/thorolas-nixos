{ pkgs, lib, home-manager, ... }:

let 
  modules-loader = import ./modules-loader.nix { inherit lib pkgs home-manager; };
  scripts-loader = import ./scripts-loader.nix { inherit lib pkgs home-manager; };
in {
  create-user = { modules, scripts, packages, ... }@args:
    { config, pkgs, ... }: 
      let
        modules-content = modules-loader.load modules;
        scripts-content = scripts-loader.load scripts;

        loaded-home-config = if args ? home-config 
          then args.home-config { inherit config pkgs; }
          else {};
      in {
        home.shellAliases = (modules-content.aliases or {})
                         // (scripts-content.aliases or {});

        home.packages = (packages) 
                     ++ (modules-content.packages or [])
                     ++ (scripts-content.packages or []);

        home.file = (modules-content.sources or {})
                 // (scripts-content.sources or {});

        programs = modules-content.programs;
      } // loaded-home-config; 
}
