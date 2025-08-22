{ users-loader, database, ... }:

users-loader.create-common {
  modules = [ "firefox" "nvim" "kitty" ];
  scripts = [ ];
  packages = with database.pkgs; [ ];

  home-config = { config, pkgs, ... }: {
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "org.pwmt.zathura.desktop";
      };
    };
  };
}
