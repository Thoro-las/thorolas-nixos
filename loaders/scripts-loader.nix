{ lib, pkgs, ... }: 

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
      loaded-script-files = lib.map (script-name:
        let
          script = import ../scripts/${script-name}.nix;
          fullscript = get-fullscript script;
        in pkgs.writeTextFile {
            name = script.name;
            destination = "/bin/${script-name}";
            executable = true;
            text = fullscript;
          }
      ) package-names.scripts;
    in with pkgs; loaded-script-files ++ loaded-script-languages;
}
