{ users-loader, database, ... }:

users-loader.create-user {
  modules = with database; [
    modules.firefox
    modules.nvim
    modules.kitty
    modules.shell
    modules.files
    modules.utils
    modules.dev
    modules.git
    modules.gitui
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
