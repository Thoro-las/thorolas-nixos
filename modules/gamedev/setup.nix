
{ pkgs, lib, ... }:

{
  module = {
    packages = [
      pkgs.godot

      pkgs.libresprite

      pkgs.blender
      pkgs.blockbench

      pkgs.sfxr
      pkgs.sfxr-qt
      pkgs.lmms
    ];
  };
}
