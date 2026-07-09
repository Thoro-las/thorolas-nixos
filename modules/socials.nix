{ pkgs, ... }:
{
  module = {
    packages = [
      pkgs.discord
      pkgs.youtube-music
      pkgs.telegram-desktop
    ];
  };
}
