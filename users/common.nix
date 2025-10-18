{ users-loader, database, ... }:

users-loader.create-user {
  modules = with database; [
    modules.nvim
    modules.kitty
    modules.shell
    modules.dev
    modules.gradle
    modules.git
    modules.gitui
    modules.fish

    modules.utils

    modules.files
    modules.typing

    modules.firefox
    modules.socials
    modules.sage
  ];

  scripts = with database; [
    scripts.thrnix
  ];

  home-config = { config, pkgs, ... }: {
    services.swaync.enable = true;

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "org.pwmt.zathura.desktop";
      };
    };
  };
}
