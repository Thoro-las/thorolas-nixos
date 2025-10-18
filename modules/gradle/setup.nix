{ lib, pkgs, home-manager, ... }:

{
  module = {
    program = "gradle";
  };

  config = {
    enable = true;
  };
}
