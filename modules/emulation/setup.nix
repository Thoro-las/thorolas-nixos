{ pkgs, ... }:
{
  module = {
    packages = [
      pkgs.bottles
    ];
  };
}
