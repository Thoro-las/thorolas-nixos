{ pkgs, ... }:
{
  module = {
    packages = [
      # pkgs.wine
      pkgs.bottles
      # pkgs.winetricks
      # pkgs.wineWowPackages.stable
      pkgs.vulkan-tools
    ];
  };
}
