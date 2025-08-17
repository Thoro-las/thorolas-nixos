let
  nixpkgs = import <nixpkgs> {};
  home-manager = import <home-manager> {};
  lib = nixpkgs.lib;
  pkgs = nixpkgs.legacyPackages."x86_64-linux";
in {
  users-loader = import ../loaders/users-loader.nix { inherit pkgs lib home-manager; };
}
