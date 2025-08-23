{ lib, pkgs, home-manager, ... }:

{
  module = {
    program = "gitui";
  };

  config = {
    enable = true;
  };
}
