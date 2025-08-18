{ lib, pkgs, home-manager, ... }:

{
  module = {
    program = "firefox";

    sources = {
      ".mozilla/firefox/default/xulstore.json".source = ./xulstore.json;
    };
  };

  config = {
    enable = true;

    profiles.default = {
      id = 0;
      name = "default";

      extensions = with pkgs.nur.repos.rycee.firefox-addongs; [
        downthemall
        return-youtube-dislikes
        multiselect-for-youtube
        adaptive-tab-bar-colour
        tabliss
        vimium-c
      ];

      search = {
        force = true;
        default = "DuckDuckGo";
        privateDefault = "DuckDuckGo";

        engines = {
          "GitHub" = {
            urls = [{ template = "https://github.com/search?q={searchTerms}"; }];
            definedAliases = [ "@gh" ];
          };
        };
      };

      bookmarks = [
        { name = "GitHub"; url = "https://github.com"; }
        { name = "NixOS"; url = "https://nixos.org"; }
      ];
    };
  };
}
