{ lib, pkgs, home-manager, ... }:

{
  module = {
    packages = [
      pkgs.git
    ];
  };
}
