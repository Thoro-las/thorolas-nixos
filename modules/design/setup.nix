{ lib, pkgs, home-manager, ... }:

{
  module = {
    packages = [
      pkgs.inkscape
      pkgs.krita
      pkgs.htop
    ];
  };
}
