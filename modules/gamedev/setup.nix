
{ pkgs, lib, ... }:

{
  module = {
    packages = [
      pkgs.godot
      pkgs.blender
      pkgs.aseprite
      pkgs.skia-aseprite
      pkgs.lmms
    ];
  };

}
