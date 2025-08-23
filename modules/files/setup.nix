{ lib, pkgs, home-manager, ... }:

{
  module = {
    packages = [
      pkgs.zathura
      pkgs.vimiv-qt
      pkgs.yazi
    ];
  };
}
