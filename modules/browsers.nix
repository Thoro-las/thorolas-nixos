{ lib, pkgs, home-manager, ... }:

{
  module = {
    packages = [
      pkgs.firefox
      pkgs.brave
      pkgs.qutebrowser
    ];
  };
}
