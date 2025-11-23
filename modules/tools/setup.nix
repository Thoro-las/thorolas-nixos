{ pkgs, ... }:
{
  module = {
    packages = [
      pkgs.wireshark
    ];
  };
}
