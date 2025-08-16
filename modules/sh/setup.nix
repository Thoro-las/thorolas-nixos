{ ... }:

{
  config = {
    enableCompletion = true;
    shellAliases = {
      ll = "ls -l";
      gs = "git status";
      hl = "echo 'hello'";
    };

    history.size = 10000;
    history.ignoreAllDups = true;
    history.ignorePatterns = ["rm *" "cp *"];
  };
}
