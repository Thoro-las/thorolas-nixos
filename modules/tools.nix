{ pkgs, ... }:
{
  module = {
    packages = [
      pkgs.vimgolf
      pkgs.fd

      pkgs.pdfcpu
    ];
  };
}
