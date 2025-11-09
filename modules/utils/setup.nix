{ pkgs, ... }:
{
  module = {
    packages = with pkgs; [
      appimage-run

      wget
      ripgrep
      trashy
      busybox

      wl-clipboard

      zip
      unzip

      connman
      connman-gtk

      openpomodoro-cli
    ];
  };
}
