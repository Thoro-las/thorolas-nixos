{ pkgs, lib, home-manager, ... }:

let
  state-version = "25.05";

  loader-utility = import ./loader-utility.nix { inherit pkgs lib; };
  users-loader = import ./users-loader.nix { inherit pkgs lib home-manager; };

  users = loader-utility.fs.list-subitems ../users "directory";
in {
  OSgroups = {
    nixos-conf = {};
  };

  OSusers = lib.listToAttrs (map (user: {
    name = user;
    value = {
      description = loader-utility.generators.get-description user;
      password = loader-utility.generators.get-password user;

      enable = true;
      isNormalUser = true;

      extraGroups = [ "wheel" "networkmanager" "nixos-conf" ];
      packages = with pkgs; [ ];

      createHome = true;
      home = loader-utility.generators.get-home user;
    };
  }) users);

  HMusers = lib.listToAttrs (map (user: {
    name = user;
    value = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ../users/common.nix

        ({ config, pkgs, ... }: {
          home.username = user;
          home.homeDirectory = loader-utility.generators.get-home user;
          home.stateVersion = state-version;
        })

        ({config, pkgs, ...}@args:
          (import (./${loader-utility.generators.get-homeconfig user})
            { inherit users-loader; }) { inherit config pkgs; }
        )
      ];
    };
  }) users);
}
