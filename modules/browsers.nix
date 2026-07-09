{ pkgs, ... }:

{
  module = {
    packages = [
      pkgs.firefox
      pkgs.brave
      pkgs.qutebrowser
    ];
  };
}
