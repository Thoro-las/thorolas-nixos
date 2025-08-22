{ nixpkgs, lib, home-manager, nur, system, ... }:

let
  state-version = "25.05";

  loader-utility = import ./loader-utility.nix { inherit pkgs lib; };
  users-loader = import ./users-loader.nix { inherit pkgs lib home-manager; };

  _ = builtins.warn "test";

  loaded-users = lib.pipe (loader-utility.fs.list-subitems ../users "directory") [
    (user-names: lib.listToAttrs (lib.map
      (user-name: {
        name = user-name;
        value = {
          home = import ../users/${user-name}/home.nix;
          credentials = import ../users/${user-name}/credentials.nix;
        };
      })
      user-names
    ))
  ];

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

  OSusers = lib.mapAttrs
    (user: user-config:
      {
        description = user-config.credentials.name or user;
        hashedPassword = user-config.credentials.password or user;

        enable = true;
        isNormalUser = true;

        extraGroups = [ "wheel" "networkmanager" "nixos-conf" ];
        packages = with pkgs; [ ];

        createHome = true;
        home = "/home/" + user;
      }
    )
    loaded-users;

  HMusers = lib.mapAttrs
    (user: user-config:
      home-manager.lib.homeManagerConfiguration {
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

	  ({ config, pkgs, ... }: 
	    user-config.home 
	      { inherit users-loader database; }
	      { inherit config pkgs; })
        ];
      }
    )
    loaded-users;
}
