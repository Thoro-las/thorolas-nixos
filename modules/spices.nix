{ pkgs, ... }:
{
  module = {
    packages = [
      pkgs.logisim-evolution
      pkgs.ngspice
      pkgs.simulide
      pkgs.digital
      pkgs.qucs-s
    ];
  };
}
