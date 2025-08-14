{ lib, pkgs, ... }: 

let
  script-database = import ../scripts/script-database.nix;
in {
  load-programs = module-names:
    let
      database = import ./modules-database.nix;
      checkExist = module: lib.hasAttr "${module}" database;
      existing-modules = lib.filter checkExist module-names;
      loaded-modules = lib.listToAttrs (lib.map (module: 
        let
          loaded-module = database.${module};
          name = loaded-module;
          extracted = if builtins.pathExists ./${module}/config.nix
            then (import (./${module}/config.nix)) // { enable = true; }
            else { enable = true; };
          
          # filter = config: lib.hasAttr "module" 
        in {
          name = name;
          value = extracted;
      }) existing-modules);
    in
      lib.recursiveUpdate loaded-modules {
        home-manager.enable = true;
      };
    

  load-packages = package-names:
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

      loaded-packages = with pkgs; lib.map (package-name: 
        pkgs.${package-name}
      ) package-names.packages;

      loaded-script-languages = lib.filter (package: package != null)
        (lib.mapAttrsToList (name: lang: lang.package) shebangs);

      loaded-script-programs = lib.map (script-name:
        let 
          script = import ../scripts/${script-name}.nix;
          fullscript = ''
            ${shebangs.${script.language}.shebang}
            ${script.script}
          '';
        in pkgs.writeTextFile {
            name = script.name;
            destination = "/bin/${script-name}";
            executable = true;
            text = fullscript;
          }
      ) package-names.scripts;

      loaded-scripts = loaded-script-programs ++ loaded-script-languages;
    in
    with pkgs; loaded-scripts ++ loaded-packages;

  # load-all = config: {
  #   programs = load-programs config.
  # };
}
