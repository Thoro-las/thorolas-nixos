{ pkgs, ... }:
{
  module = {
    packages = [
      pkgs.typst
      pkgs.typst-live
      pkgs.typstyle
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
