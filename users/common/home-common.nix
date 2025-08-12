{ config, pkgs, module-loader, ... }:

{
  systemd.user.startServices = "sd-switch";
  # home.sessionVariables = {
  #   EDITOR = "nvim";
  # };

  programs = module-loader.load-programs [ "htop" ];
}
