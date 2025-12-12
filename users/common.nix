{ users-loader, database, ... }:

users-loader.create-user {
  modules = with database; [
    modules.nvim
    modules.kitty
    modules.shell
    modules.dev
    modules.git
    modules.gitui
    modules.fish

    modules.utils
    modules.tools

    modules.files
    modules.typing

    modules.firefox
    modules.socials
    modules.sage
  ];

  scripts = with database; [
    scripts.thrnix
    scripts.thrupl
    scripts.thrpm
  ];

  home-config = { config, pkgs, ... }: {
    services.swaync.enable = true;

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "org.pwmt.zathura.desktop";
        "application/zip" = "xarchiver.desktop";
      };
    };
  };
}
