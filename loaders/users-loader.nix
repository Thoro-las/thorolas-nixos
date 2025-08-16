{ pkgs, lib, home-manager, ... }:

let 
  modules-loader = import ./modules-loader.nix { inherit lib pkgs home-manager; };
  scripts-loader = import ./scripts-loader.nix { inherit lib pkgs home-manager; };
in {
  create-user = { modules, scripts, packages, home-config, ... }:
    { config, pkgs, ... }: 
      let
        modules-content = modules-loader.load modules;
        scripts-content = scripts-loader.load scripts;
      in {
        # home.shellAliases = modules-content.aliases // scripts-content.aliases;
        home.packages = modules-content.packages ++ scripts-content.packages;
        programs = modules-content.programs;
      } // home-config { inherit config pkgs; };
}
