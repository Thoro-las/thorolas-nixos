{ pkgs, ... }:
{
  module = {
    packages = with pkgs; [
      appimage-run
      ripgrep
      trashy
      wl-clipboard
      wget

      networkmanager_dmenu
    ];
  };
}
