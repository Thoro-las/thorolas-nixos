let 
  modules-loader = import ./modules-loader.nix { inherit lib pkgs; };
  scripts-loader = import ./scripts-loader.nix { inherit lib pkgs; };
in {
  create-user = { modules, scripts, packages }:
  let
      modules-content = modules-loader.load modules;
      scripts-content = scripts-loader.load scripts;
    in { config, pkgs, ... }: {
      home.shellAliases = modules-content.aliases // scripts-content.aliases;
      home.packages = modules-content.packages // scripts-contents.packages;
      programs = modules-content.programs;
    };
}
