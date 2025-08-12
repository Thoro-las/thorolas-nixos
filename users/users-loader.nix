{ pkgs, lib, home-manager, ... }:

let
  users = import ./users-config.nix;
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

  HMusers = lib.mapAttrs (_: values: 
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./${values.path} ];
    }
  ) users;
}
