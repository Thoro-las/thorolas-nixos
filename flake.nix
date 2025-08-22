{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, nur, ... }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        system = system;
        config = {
          allowUnfree = true;
        };
      };

      loadedUsers = import loaders/configs-loader.nix {
        inherit lib home-manager nur system;
        nixpkgs = pkgs;
      };
    in
    {
      homeConfigurations = loadedUsers.HMusers;
      nixosConfigurations = {
        thorolas = lib.nixosSystem {
          inherit system;
          modules = [
            system/configuration.nix
            ({ pkgs, ... }: {
              users.mutableUsers = false;
              users.users = loadedUsers.OSusers // {
                root = {
                  hashedPassword = "$y$j9T$94N5V1zFu894r2GaVkTut1$u9hnEfJw6qdSQrHfFh6mkjAoCaQM8T6b04xp52hqgHC";
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
