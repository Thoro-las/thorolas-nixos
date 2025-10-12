{ pkgs, ... }:
{
  module = {
    packages = [
      pkgs.typst
      pkgs.typst-live
      pkgs.typst-fmt
      pkgs.tinymist

      pkgs.inkscape
    ];

    sources = {
      ".local/share/typst/packages" = {
        source = ./packages;
        recursive = true;
      };
    };
  };
}
