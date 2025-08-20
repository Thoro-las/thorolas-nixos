{ lib, pkgs, home-manager, ... }:

{
  module = {
    program = "firefox";
    packages = [ ];
    aliases = { };
    sources = {
      ".mozilla/firefox/default/prefs.js".source = ./prefs.js;
    };
  };

  config = {
    enable = true;

    profiles.default = {
      id = 0;
      name = "default";

      extensions = {
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          downthemall
          return-youtube-dislikes
          multiselect-for-youtube
          adaptive-tab-bar-colour
          tabliss
          vimium-c
        ];
      };

      search = {
        force = true;
        default = "ddg";
        privateDefault = "ddg";

        engines = {
          "GitHub" = { urls = [{ template = "https://github.com/search?q={searchTerms}"; }]; definedAliases = [ "@gh" ]; };
          "Perplexity AI" = { urls = [{ template = "https://perplexity.ai/?q={searchTerms}"; }]; definedAliases = [ "@per" ]; };
          "My NixOS" = { urls = [{ template = "https://mynixos.com/search?q={searchTerms}"; }]; definedAliases = [ "@myn" ]; };
        };
      };

      bookmarks = [
        { name = "GitHub"; url = "https://github.com"; }
        { name = "NixOS"; url = "https://nixos.org"; }
      ];
    };

  };
}
