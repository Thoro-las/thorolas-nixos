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

      pkgs.mpv

      pkgs.sqlitebrowser
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
