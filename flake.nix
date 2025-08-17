{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {self, nixpkgs, home-manager, ...}@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";

      pkgs = nixpkgs.legacyPackages.${system};
      loadedUsers = import loaders/configs-loader.nix {
          inherit pkgs lib home-manager; };
    in {
      homeConfigurations = loadedUsers.HMusers;
      nixosConfigurations = {
        thorolas = lib.nixosSystem {
          inherit system;
          modules = [
            system/configuration.nix
            ({ pkgs, ... }: {
              users.mutableUsers = false;
              users.users = loadedUsers.OSusers // {
                rescue = {
                  description = "Rescue";
                  password = "rescue";

                  enable = true;
                  isNormalUser = true;

                  extraGroups = [ "wheel" "networkmanager" ];
                  packages = with pkgs; [ ];

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
