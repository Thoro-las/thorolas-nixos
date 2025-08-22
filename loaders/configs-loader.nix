{ nixpkgs, lib, home-manager, nur, system, ... }:

let
  state-version = "25.05";

  loader-utility = import ./loader-utility.nix { inherit pkgs lib; };
  users-loader = import ./users-loader.nix { inherit pkgs lib home-manager; };

  users = loader-utility.fs.list-subitems ../users "directory";

  pkgs = import nixpkgs.path {
    inherit system;
    overlays = [ nur.overlays.default ];
  };

  database = {
    pkgs = pkgs;
    custom-pkgs = { };
  };
in
{
  OSgroups = {
    nixos-conf = { };
  };

  OSusers = lib.listToAttrs (map
    (user:
      let
        credentials = import ../users/${user}/credentials.nix;
      in
      {
        name = user;
        value = {
          description = credentials.name or user;
          hashedPassword = credentials.password or user;

          enable = true;
          isNormalUser = true;

          extraGroups = [ "wheel" "networkmanager" "nixos-conf" ];
          packages = with pkgs; [ ];

          createHome = true;
          home = "/home/" + user;
        };
      })
    users);

  HMusers = lib.listToAttrs (map
    (user: {
      name = user;
      value = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs;
        modules = [
          ({ config, pkgs, ... }@args:
            (import (../users/common.nix)
              { inherit users-loader database; })
              { inherit config pkgs; }
          )

          ({ config, pkgs, ... }: {
            home.username = user;
            home.homeDirectory = "/home/" + user;
            home.stateVersion = state-version;
          })

          ({ config, pkgs, ... }@args:
            (import (../users/${user}/home.nix)
              { inherit users-loader database; })
              { inherit config pkgs; }
          )
        ];
      };
    })
    users);
}
