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
      url."git@github.com:".insteadOf = "https://github.com/";
      safe.directory = "/etc/nixos";
    };
  };
}
