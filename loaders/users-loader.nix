{ pkgs, lib, home-manager, ... }:

let
  utility = import ./loader-utility.nix { inherit pkgs lib; };
  module-loader = import ./modules-loader.nix { inherit lib pkgs; };
  state-version = "25.05";

  users = utility.fs.list-subitems ../users "directory";
in {
  OSgroups = {
    nixos-conf = {};
  };

  OSusers = lib.listToAttrs (map (user: {
    name = user;
    value = {
      description = utility.generators.get-description user;
      password = utility.generators.get-password user;

      enable = true;
      isNormalUser = true;

      extraGroups = [ "wheel" "networkmanager" "nixos-conf" ];
      packages = with pkgs; [ ];

      createHome = true;
      home = utility.generators.get-home user;
    };
  }) users);

  HMusers = lib.listToAttrs (map (user: {
    name = user;
    value = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./common/home-common.nix
        ./${utility.generators.get-homeconfig user}
        ({ config, pkgs, module-loader, ... }: {
          home.username = user;
          home.homeDirectory = utility.generators.get-home user;
          home.stateVersion = state-version;
        })
      ];

      extraSpecialArgs = {
        module-loader = module-loader;
      };
    };
  }) users);
}
