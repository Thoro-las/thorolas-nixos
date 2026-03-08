{ pkgs, ... }:
{
  module = {
    packages = [
      pkgs.gns3-gui
      pkgs.gns3-server
    ];
  };
}
