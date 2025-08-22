{ users-loader, database, ... }:

users-loader.create-user {
  modules = [ "firefox" "nvim" "kitty" "shell" "design" ];
  packages = [];
  scripts = [];

  home-config = { config, pkgs, ... }: {
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "org.pwmt.zathura.desktop";
      };
    };
  };
}
