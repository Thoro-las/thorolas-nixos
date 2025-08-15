{ lib, pkgs, home-manager, ... }: 

let
  shebangs = {
    bash = {
      shebang = "#!/usr/bin/env bash";
      package = null;
    };

    python = {
      shebang = "#!/usr/bin/env python3";
      package = pkgs.python3;
    };
  };

  loaded-script-languages = lib.pipe shebangs [
    (shebangs: lib.mapAttrsToList (_: lang: lang.package) shebangs)
    (packages: lib.filter (package: package != null) packages)
  ];

  get-fullscript = script: ''
    ${shebangs.${script.language}.shebang}
    ${script.script}
  '';
in {
  load = script-names:
    let
      check-exist = script: builtins.pathExists ../scripts/${script}.nix;
      loaded-scripts = lib.pipe script-names [
        (script-names: lib.filter check-exist script-names)
        (existing-scripts: (script: import ../scripts/${script}.nix { inherit pkgs lib home-manager; }) existing-scripts)
      ];

      loaded-script-files = lib.map (script:
        pkgs.writeTextFile {
          name = script.name;
          destination = "/bin/${script.name}";
          executable = true;
          text = get-fullscript script;
        }
      ) loaded-scripts;
    in {
      packages = with pkgs; loaded-script-files ++ loaded-script-languages;
      aliases = lib.lists.concatmap (script: script.aliases;) loaded-scripts;
    }
}
