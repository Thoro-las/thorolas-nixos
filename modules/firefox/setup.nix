{ lib, pkgs, home-manager, ... }:

{
  module = {
    program = "firefox";
    packages = [ ];
    aliases = { };
    sources = { ".mozilla/firefox/default/prefs.js".source = ./prefs.js; };
  };

  config = {
    enable = true;

    profiles.default = {
      id = 0;
      name = "default";

      extensions = {
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          vimium-c
          nighttab
          ghostery
          dark-mode-webextension
          return-youtube-dislikes
          adaptive-tab-bar-colour
        ];
      };

      search = {
        force = true;
        default = "ddg";
        privateDefault = "ddg";

        engines = {
          "GitHub" = {
            urls =
              [{ template = "https://github.com/search?q={searchTerms}"; }];
            definedAliases = [ "@gh" ];
          };

          "Perplexity AI" = {
            urls = [{ template = "https://perplexity.ai/?q={searchTerms}"; }];
            definedAliases = [ "@per" ];
          };

          "DeepSeek" = {
            urls =
              [{ template = "https://chat.deepseek.com/?q={searchTerms}"; }];
            definedAliases = [ "@dc" ];
          };

          "DeepWiki" = {
            urls = [{ template = "https://deepwiki.com/{searchTerms}"; }];
            definedAliases = [ "@dwi" ];
          };

          "My NixOS" = {
            urls =
              [{ template = "https://mynixos.com/search?q={searchTerms}"; }];
            definedAliases = [ "@myn" ];
          };

          "ProofWiki" = {
            urls = [{
              template =
                "https://proofwiki.org/w/index.php?search={searchTerms}";
            }];
            definedAliases = [ "@prf" ];
          };
        };
      };

      bookmarks = {
        force = true;
        settings = [
          {
            name = "GitHub";
            url = "https://github.com";
          }
          {
            name = "NixOS";
            url = "https://nixos.org";
          }
          {
            name = "Perplexity";
            url = "https://perplexity.ai";
          }
        ];
      };
    };

  };
}
