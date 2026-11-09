{ pkgs, ... }:

let
  oldpkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/nixos-25.11.tar.gz";
    sha256 = "0ln4yw7z3g9lb0x081hc0pd2j1wsx2qqf6bgmwwvdbkcl4bcy1dp";
  }) { system = pkgs.system; };
in
{
  module = {
    packages = [
      pkgs.mesa
      pkgs.vulkan-loader
      pkgs.vulkan-tools

      pkgs.winetricks
      pkgs.wineWow64Packages.full
      pkgs.vulkan-tools

      pkgs.mame

      pkgs.balatro-mod-manager

      pkgs.frotz

      (oldpkgs.bottles.override { removeWarningPopup = true; })
    ];
  };
}
