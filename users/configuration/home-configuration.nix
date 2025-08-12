{ config, pkgs, module-loader, ... }:

{
  programs = module-loader.load-programs [ "sh" ];
  home.packages = module-loader.load-packages {
    packages = [];
    scripts = [ "hergo" ];
  };
}
