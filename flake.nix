{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    flake-utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";

      loaded-overlays =
        builtins.readDir ./overlays
        |> builtins.attrNames
        |> builtins.filter (lib.hasSuffix ".nix")
        |> builtins.map (name: import (./overlays/${name}));

      pkgs = import nixpkgs {
        system = system;
        config.allowUnfree = true;
        overlays =
          [ inputs.nur.overlays.default ]
          ++ loaded-overlays;
      };

      loadedUsers = import ./loaders/configs-loader.nix {
        inherit pkgs lib home-manager;
      };
    in {
      homeConfigurations = loadedUsers.HMusers;
      nixosConfigurations = {
        thorolas = lib.nixosSystem {
          inherit system;
          modules = [
            system/configuration.nix

            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }

            ({ pkgs, ... }: {
              users.mutableUsers = false;
              users.users = loadedUsers.OSusers // {
                root = {
                  hashedPassword =
                    "$y$j9T$94N5V1zFu894r2GaVkTut1$u9hnEfJw6qdSQrHfFh6mkjAoCaQM8T6b04xp52hqgHC";
                };

                rescue = {
                  description = "Rescue";
                  password = "rescue";

                  enable = true;
                  isNormalUser = true;

                  extraGroups = [ "wheel" "networkmanager" ];

                  createHome = true;
                  home = "/home/rescue";
                };
              };
              users.groups = loadedUsers.OSgroups;
            })
          ];
        };
      };
    };
}
