{ lib, pkgs, home-manager, ... }:

{
  module = {
    packages = [
      pkgs.zathura
      pkgs.vimiv-qt
      pkgs.yazi
      pkgs.mpv

      pkgs.usbutils
      pkgs.udisks
      pkgs.udiskie
      pkgs.gparted
      pkgs.ncdu

      pkgs.libreoffice
      pkgs.sqlitebrowser

      pkgs.unrar
      pkgs.qbittorrent-enhanced
      pkgs.xarchiver
    ];
  };

  config = {
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "org.pwmt.zathura.desktop";
        "application/zip" = "xarchiver.desktop";
      };
    };
  };
}
