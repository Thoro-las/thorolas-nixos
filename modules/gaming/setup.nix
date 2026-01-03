{ pkgs, ... }:
{
  module = {
    packages = [
      pkgs.mesa
      pkgs.vulkan-loader
      pkgs.vulkan-tools

      pkgs.bottles
      pkgs.winetricks
      pkgs.wineWowPackages.stable
      pkgs.vulkan-tools
    ];
  };
}
