{ lib, pkgs, home-manager, ... }:

{
  module = {
    program = "git";
  };

  config = {
    enable = true;

    settings = {
      user.name = "thorolas";
      user.email = "had.azouaou@gmail.com";
      safe.directory = "/etc/nixos";
    };
  };
}
