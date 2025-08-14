let
  nixpkgs = import <nixpkgs> {};
in {
  pkgs = nixpkgs.legacyPackages."x86_64-linux";
  lib = nixpkgs.lib;
}
