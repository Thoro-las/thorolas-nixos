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
      oldpkgs.zathura

      pkgs.vimiv-qt
      pkgs.yazi
      pkgs.mpv

      pkgs.onlyoffice-desktopeditors
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
