{ pkgs, ... }:
{
  module = {
    packages = [
      pkgs.skia
      pkgs.eww
      pkgs.rofi
      pkgs.dmenu
      pkgs.notify
      pkgs.libnotify
      pkgs.feh
    ];
  };
}
