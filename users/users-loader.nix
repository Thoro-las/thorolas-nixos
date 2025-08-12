{ pkgs, lib, home-manager, ... }:

let
  users = import ./users-config.nix;
  module-loader = import ../modules/modules-loader.nix { inherit lib pkgs; };
in {
  OSgroups = {
    nixos-conf = {};
  };

  OSusers = lib.mapAttrs (name: values: {
    description = values.description;
    password = values.password;

    enable = true;
    isNormalUser = true;

    extraGroups = [ "wheel" "networkmanager" "nixos-conf" ];
    packages = with pkgs; [ ];

    createHome = true;
    home = values.homedir;
  }) users;

  HMusers = lib.mapAttrs (name: values: 
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./common/home-common.nix
        ./${values.path}
        ({ config, pkgs, module-loader, ... }: {
          home.username = name;
          home.homeDirectory = "/home/${name}";
          home.stateVersion = "25.05";
        })
      ];
      extraSpecialArgs = {
        module-loader = module-loader;
      };
    }
  ) users;
}
