{ pkgs, ... }:
{
  module = {
    packages = with pkgs; [
      appimage-run
      ripgrep
      trashy
      wl-clipboard
      wget

      zip
      unzip

      networkmanager_dmenu
    ];
  };
}
