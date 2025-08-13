{ pkgs, lib, home-manager, ... }:

let
  utility = import ./utility.nix { inherit pkgs lib; };
  module-loader = import ./modules-loader.nix { inherit lib pkgs; };
  state-version = "25.05";

  users = utility.list-subitems ../users "directory";
in {
  OSgroups = {
    nixos-conf = {};
  };

  OSusers = lib.map (user: {
    description = utility.generate-description user;
    password = utility.generate-password user;

    enable = true;
    isNormalUser = true;

    extraGroups = [ "wheel" "networkmanager" "nixos-conf" ];
    packages = with pkgs; [ ];

    createHome = true;
    home = utility.generate-home user;
  }) users;

  HMusers = lib.map (user:
    user = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./common/home-common.nix
        ./${utility.generate-home-config user}
        ({ config, pkgs, module-loader, ... }: {
          home.username = name;
          home.homeDirectory = "/home/${name}";
          home.stateVersion = state-version;
        })
      ];

      extraSpecialArgs = {
        module-loader = module-loader;
      };
    }) users;
}
