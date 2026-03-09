{
  pkgs,
  lib,
  home-manager,
  ...
}:

let
  loader-utility = import ./loader-utility.nix { inherit pkgs lib; };
  users-loader = import ./users-loader.nix { inherit pkgs lib home-manager; };

  loaded-users =
    (loader-utility.fs.list-subitems ../users "directory")
    |> lib.map (user-name: {
      name = user-name;
      value = {
        home = import ../users/${user-name}/home.nix;
        credentials = import ../users/${user-name}/credentials.nix;
      };
    })
    |> lib.listToAttrs;

  database = loader-utility.get-database;
in
{
  OSgroups = { };

  OSusers = lib.mapAttrs (user: user-config: {
    description = user-config.credentials.name or user;
    hashedPassword = user-config.credentials.password or user;

    enable = true;
    isNormalUser = true;

    extraGroups = [
      "wheel"
      "networkmanager"
    ];

    createHome = true;
    home = "/home/" + user;
  }) loaded-users;

  HMusers = lib.mapAttrs (
    user: user-config:
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        (
          { config, pkgs, ... }:
          (import (../users/common.nix) { inherit users-loader database; }) { inherit home-manager config pkgs; }
        )

        (
          { config, pkgs, ... }: user-config.home { inherit users-loader database; } { inherit home-manager config pkgs; }
        )

        (
          { config, pkgs, ... }:
          {
            home.username = user;
            home.homeDirectory = "/home/" + user;
            home.stateVersion = "25.05";
          }
        )

        ({ config, pkgs, ... }: import ../display/hyprland/default.nix { inherit pkgs; })
      ];
    }
  ) loaded-users;
}
