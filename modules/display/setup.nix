{ pkgs, ... }:
{
  module = {
    packages = [
      pkgs.eww
      pkgs.rofi
      pkgs.dmenu
      pkgs.notify
      pkgs.libnotify
      pkgs.feh
    ];
  };
}
