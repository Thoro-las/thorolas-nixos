{ pkgs, ... }:
{
  module = {
    packages = [
      pkgs.python3
      pkgs.gcc
      pkgs.lua5_1
      pkgs.gnumake
      pkgs.dotnet-sdk
    ];
  };
}
