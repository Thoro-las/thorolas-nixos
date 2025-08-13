{ config, pkgs, module-loader, ... }:

{
  systemd.user.startServices = "sd-switch";

  programs = module-loader.load-programs [ "nvim" ];
}
