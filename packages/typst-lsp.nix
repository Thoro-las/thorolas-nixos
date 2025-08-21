{ pkgs }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "typst-lsp";
  version = "0.13.0";

  src = pkgs.fetchCrate {
    inherit pname version;
    sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  cargoSha256 = "sha256-BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=";
}
