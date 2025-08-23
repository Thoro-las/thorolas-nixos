{ pkgs, ... }:
{
  module = {
    packages = [
      pkgs.appimage-run
      pkgs.ripgrep
      pkgs.trashy
      pkgs.xclip
      pkgs.wget
    ];
  };
}
