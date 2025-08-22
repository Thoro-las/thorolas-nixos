{ pkgs, ... }:
{
  module = {
    program = "program";
    packages = with pkgs; [ "packages" ];
    sources = {};
    aliases = {};
  };

  config = {
    enable = true;
  };
}
