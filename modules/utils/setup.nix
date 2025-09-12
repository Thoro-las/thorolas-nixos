{ pkgs, ... }:
{
  module = {
    packages = with pkgs; [
      appimage-run
      ripgrep
      trashy
      xsel
      wget
    ];
  };
}
