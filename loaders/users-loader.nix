{ pkgs, lib, home-manager, ... }:

let
  modules-loader = import ./modules-loader.nix { inherit lib pkgs home-manager; };
  scripts-loader = import ./scripts-loader.nix { inherit lib pkgs home-manager; };
in
{
  create-user = { ... }@args:
    { config, pkgs, ... }:
    let
      dependencies = { inherit lib pkgs home-manager config; };
      modules-content = modules-loader.load dependencies (args.modules or [ ]);
      scripts-content = scripts-loader.load dependencies (args.scripts or [ ]);

      loaded-home-config =
        if args ? home-config
        then args.home-config { inherit home-manager config pkgs; }
        else { };
    in
    {
      home.shellAliases = (modules-content.aliases or { })
      // (scripts-content.aliases or { });

      home.packages = (args.packages or [ ])
      ++ (modules-content.packages or [ ])
      ++ (scripts-content.packages or [ ]);

      home.file = (modules-content.sources or { })
      // (scripts-content.sources or { });

      programs = modules-content.programs;
    } // loaded-home-config;
}
