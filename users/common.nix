{ users-loader, database, ... }:

users-loader.create-user {
  modules = with database; [
    modules.nvim
    modules.kitty
    modules.shell
    modules.dev
    modules.git
    modules.fish

    modules.utils
    modules.tools

    modules.files
    modules.typing

    modules.browsers
    modules.socials

    modules.spices

    modules.design
    modules.recording
    modules.gamedev

    modules.gaming
    modules.emulation
  ];

  scripts = with database; [
    scripts.thrnix
    scripts.thrupl
    scripts.thrpm

    scripts.powermenu
  ];

  home-config = { home-manager, config, pkgs, ... }: {
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "org.pwmt.zathura.desktop";

        "application/zip" = "xarchiver.desktop";
        "application/rar" = "xarchiver.desktop";

        "image/png" = "vimiv.desktop";
        "image/jpeg" = "vimiv.desktop";
        "image/jpg" = "vimiv.desktop";
        "image/gif" = "vimiv.desktop";
        "image/bmp" = "vimiv.desktop";
        "image/tiff" = "vimiv.desktop";
        "image/webp" = "vimiv.desktop";
      };
    };
  };
}
