{ pkgs, ... }:
{
  module = {
    packages = [
      pkgs.mesa
      pkgs.vulkan-loader
      pkgs.vulkan-tools

      pkgs.winetricks
      pkgs.wineWowPackages.stable
      pkgs.vulkan-tools

      pkgs.prismlauncher

      (pkgs.bottles.override { removeWarningPopup = true; })
    ];
  };
}
