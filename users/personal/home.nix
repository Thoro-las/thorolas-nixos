{ config, pkgs, module-loader, ... }:

{
  programs = module-loader.load-programs [ "ftube" ];
  home.packages = module-loader.load-packages {
    packages = [];
    scripts = [ "hergo" ];
  };
}
