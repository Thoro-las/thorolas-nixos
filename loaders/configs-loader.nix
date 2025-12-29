{ nixpkgs, lib, home-manager, nur, system, ... }:

let
  state-version = "25.05";

  overlays-directory = ../overlays;
  overlay-names = builtins.filter (name: lib.hasSuffix ".nix" name)
    (builtins.attrNames (builtins.readDir overlays-directory));
  loaded-overlays =
    map (name: import ("${overlays-directory}/${name}")) (overlay-names);
  
  pkgs = import nixpkgs.path {
    inherit system;
    config.allowUnfree = true;
    overlays = loaded-overlays ++ [ nur.overlays.default ];
  };

  loader-utility = import ./loader-utility.nix { inherit pkgs lib; };
  users-loader = import ./users-loader.nix { inherit pkgs lib home-manager; };

  loaded-users = lib.pipe (loader-utility.fs.list-subitems ../users "directory")
    [
      (user-names:
        lib.listToAttrs (lib.map (user-name: {
          name = user-name;
          value = {
            home = import ../users/${user-name}/home.nix;
            credentials = import ../users/${user-name}/credentials.nix;
          };
        }) user-names))
    ];

  database = loader-utility.get-database;
in {
  OSgroups = { nixos-conf = { }; };

  OSusers = lib.mapAttrs (user: user-config: {
    description = user-config.credentials.name or user;
    hashedPassword = user-config.credentials.password or user;

    enable = true;
    isNormalUser = true;

    extraGroups = [ "wheel" "networkmanager" "nixos-conf" ];
    packages = with pkgs; [ ];

    createHome = true;
    home = "/home/" + user;
  }) loaded-users;

  HMusers = lib.mapAttrs (user: user-config:
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [


        ({ config, pkgs, ... }@args:
          (import (../users/common.nix) { inherit users-loader database; }) {
            inherit config pkgs;
          })

        ({ config, pkgs, ... }: {
          home.username = user;
          home.homeDirectory = "/home/" + user;
          home.stateVersion = state-version;
        })

        ({ config, pkgs, ... }:
          import ../interface/hyprland/default.nix { inherit pkgs; })

        ({ config, pkgs, ... }:
          user-config.home { inherit users-loader database; } {
            inherit config pkgs;
          })
      ];
    }) loaded-users;
}
