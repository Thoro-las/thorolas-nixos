let
  # Define your inputs - adjust these paths/versions as needed
  nixpkgs = builtins.getFlake "nixpkgs";
  home-manager = builtins.getFlake "github:nix-community/home-manager";
  nur = builtins.getFlake "github:nix-community/NUR";
  
  # Or if you're using a flake.lock, you can reference it:
  # nixpkgs = (builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.nixpkgs.locked;
  
  lib = nixpkgs.lib;
  system = "x86_64-linux"; # or your target system
  
  # Import your configs-loader with all dependencies
  configs-loader = import ../loaders/configs-loader.nix {
    inherit nixpkgs lib home-manager nur system;
  };
in
configs-loader
