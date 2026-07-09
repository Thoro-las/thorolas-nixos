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
      swww

      usbutils
      udisks
      udiskie
      gparted
      ncdu
    ];
  };
}
