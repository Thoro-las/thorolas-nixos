{ pkgs, ... }:
{
  module = {
    packages = [
      pkgs.discord
      pkgs.pear-desktop
      pkgs.telegram-desktop
    ];
  };
}
