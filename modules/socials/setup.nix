{ pkgs, ... }:
{
  module = {
    packages = [
      pkgs.discord
    ];
  };
}
