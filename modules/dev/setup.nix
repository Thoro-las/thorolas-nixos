{ pkgs, ... }:
{
  module = {
    packages = [
      (pkgs.python3.withPackages (ps: with ps; [ 
        jupyter 
        notebook 
        numpy 
        pandas
        pip
      ]))

      pkgs.gcc
      pkgs.tinycc
      pkgs.lua5_1
      pkgs.gnumake

      pkgs.jdk
      pkgs.jetbrains.idea-community
      pkgs.sdkmanager

      pkgs.dotnet-sdk
      pkgs.SDL2
      pkgs.SDL2_image

      pkgs.vscode
    ];
  };
}
