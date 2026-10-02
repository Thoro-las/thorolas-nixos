{ pkgs, ... }:
{
  module = {
    packages = with pkgs; [
      appimage-run
      wl-clipboard
      desktop-file-utils

      dnsmasq
      hostapd
      wirelesstools
      iw

      input-leap
      fuse
      awww
      eww
      quickshell

      usbutils
      udisks
      udiskie
      gparted
      ncdu

      syncplay
    ];
  };
}
