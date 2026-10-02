{ pkgs, inputs, ... }:
{
  module = {
    packages = [
      pkgs.mesa
      pkgs.vulkan-loader
      pkgs.vulkan-tools

      pkgs.winetricks
      pkgs.wineWow64Packages.full
      pkgs.vulkan-tools

      pkgs.mame

      pkgs.balatro-mod-manager

      (pkgs.bottles.override { removeWarningPopup = true; })
    ];
  };
}
