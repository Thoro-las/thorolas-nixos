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

      connman
      connman-gtk

      openpomodoro-cli
    ];
  };
}
