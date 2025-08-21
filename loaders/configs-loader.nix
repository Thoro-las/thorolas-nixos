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
      pkgs = pkgs;
      modules = [
        ../users/common.nix

        ({ config, pkgs, ... }: {
          home.username = user;
          home.homeDirectory = loader-utility.generators.get-home user;
          home.stateVersion = state-version;
        })

        ({config, pkgs, ...}@args:
          let
            database = {
              pkgs = pkgs;
              custom-pkgs = {
                typst-lsp = import ../packages/typst-lsp.nix { inherit pkgs lib; };
              };
            };
          in
          (import (./${loader-utility.generators.get-homeconfig user})
            { inherit users-loader database; }) { inherit config pkgs; }
        )
      ];
    };
  }) users);
}
