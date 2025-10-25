{ lib, pkgs, home-manager, ... }:

{
  module = {
    packages = [
      pkgs.zathura
      pkgs.vimiv-qt
      pkgs.yazi

      pkgs.usbutils
      pkgs.udisks
      pkgs.udiskie

      pkgs.qbittorrent-enhanced
      pkgs.xarchiver

      pkgs.libreoffice
    ];
  };
}
