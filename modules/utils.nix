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

      usbutils
      udisks
      udiskie
      gparted
      ncdu
    ];
  };
}
