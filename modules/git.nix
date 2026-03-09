{pkgs,...}: {
  module = {
    program = "git";
    modules = [
      pkgs.gitui
    ];
  };

  config = {
    enable = true;

    settings = {
      user.name = "thorolas";
      user.email = "had.azouaou@gmail.com";
      safe.directory = "/etc/nixos";
    };
  };
}
