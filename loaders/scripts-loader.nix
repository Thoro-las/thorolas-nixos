{
  lib,
  pkgs,
  home-manager,
  ...
}:

let
  shebangs = {
    bash = {
      shebang = "#!/usr/bin/env bash";
      package = null;
    };

    python = {
      shebang = "#!/usr/bin/env python3";
      package = null;
    };
  };

  loaded-script-languages =
    shebangs |> lib.mapAttrsToList (_: lang: lang.package) |> lib.filter (package: package != null);

  get-fullscript = script: ''
    ${shebangs.${script.language or "bash"}.shebang}
    ${script.script}
  '';
in
{
  load =
    dependencies: script-names:
    let
      check-exist = script: builtins.pathExists ../scripts/${script};
      loaded-scripts =
        script-names
        |> lib.filter check-exist
        |> lib.map (script: import ../scripts/${script} dependencies);

      loaded-script-dependencies = lib.concatMap (script: script.packages or [ ]) loaded-scripts;
      loaded-script-files = lib.map (
        script:
        pkgs.writeTextFile {
          name = script.name;
          destination = "/bin/${script.name}";
          executable = true;
          text = get-fullscript script;
        }
      ) loaded-scripts;
    in
    {
      packages =
        loaded-script-languages
        ++ loaded-script-dependencies
        ++ loaded-script-files;

      aliases = 
        loaded-scripts
        |> lib.map (script: script.aliases or { })
        |> lib.attrsets.mergeAttrsList;

      sources = { };
    };
}
