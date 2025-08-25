{ lib, pkgs, home-manager, ... }:

{
  module = {
    program = "git";
  };

  config = {
    enable = true;

    userName = "thorolas";
    userEmail = "had.azouaou@gmail.com";

    extraConfig = {
      safe.directory = "/etc/nixos";
    };
  };
}
