
{ pkgs, lib, ... }:

{
  module = {
    packages = [
      pkgs.godot

      pkgs.skia-aseprite
      pkgs.libresprite

      pkgs.blender
      pkgs.blockbench

      pkgs.sfxr
      pkgs.sfxr-qt
      pkgs.lmms
    ];
  };
}
