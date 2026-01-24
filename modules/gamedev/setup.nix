
{ pkgs, lib, ... }:

{
  module = {
    packages = [
      pkgs.godot
      pkgs.blender
      pkgs.skia-aseprite
      pkgs.lmms
    ];
  };
}
