{ users-loader, database, ... }:

users-loader.create-user {
  modules = [
    "firefox"
    "nvim"
    "kitty"
    "shell"
    "files"
    "utils"
    "dev"
    "git"
    "gitui"
  ];

  home-config = { config, pkgs, ... }: {
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "org.pwmt.zathura.desktop";
      };
    };
  };
}
