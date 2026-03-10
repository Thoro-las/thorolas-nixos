{ pkgs, config, ... }:
{
  module = {
    packages = [
      pkgs.typst
      pkgs.typst-live
      pkgs.typstyle
      pkgs.tinymist

      pkgs.texliveFull

      pkgs.inkscape
    ];

    sources = {
      ".local/share/typst/packages" = {
        source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/modules/typing/packages";
        recursive = true;
      };
    };
  };
}
