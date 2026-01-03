{ pkgs, ... }:
{
  module = {
    packages = [
      pkgs.wireshark

      pkgs.vimgolf
    ];
  };
}
