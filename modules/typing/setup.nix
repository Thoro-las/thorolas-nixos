{ pkgs, ... }:
{
  module = {
    packages = [
      pkgs.typst
      pkgs.typst-live
      pkgs.typst-fmt
      pkgs.tinymist
    ];
  };
}
