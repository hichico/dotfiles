{
  description = "Chico's Nix system configs";
  
  # Inputs are the places where we get our software.
  # Giant monorepo with recipes called derivations that say how to build software.
  inputs = {
    # Package sets
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixpkgs-23.05-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Controls systems level software and settings incluiding fonts
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs-unstable";      

    # Manages config links into your config links
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs: {
    darwinConfigurations.mbp2016 = inputs.darwin.lib.darwinSystem {
      system = "aarch64-darwin";
        pkgs = import inputs.nixpkgs-stable {
          system = "aarch64-darwin";
        };
      };
      nixosModules = [
        ({pkgs, ...}: {
          # here goes the darwin preferences and configuration
          programs.fish.enable = true;
          environment.shells = [ pkgs.bash pkgs.fish ];
          environment.loginShell = [ pkgs.fish ];
          nix.extraOptions = ''experimental-features = nix-command flakes'';
          systemPackages = [ pkgs.coreutils ];
          system.keyboard.enableKeyMapping = true;
          services.nix-daemon.enable = true;
          system.defaults.finder.AppleShowAllExtensions = true;
          system.defaults.dock.autohide = true;
          system.defaults.NSGlobalDomain.InitialKeyRepeat = 14;
          system.defaults.NSGlobalDomain.KeyRepeat = 1;
        })
        (inputs.home-manager.darwinModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPkgs = true;
            users.shik0.imports = [
              ({pkgs, ...}: {
                # Specify my home manager configs
                home.packages = [ pkgs.ripgrep pkgs.fd pkgs.curl pkgs.less ];
                programs.bat.enable = true;
                programs.fzf.enable = true;
                programs.exa.enable = true;
                programs.git.enable = true;
                programs.fish.enable = true;
                programs.starship.enable = true;
                programs.alacritty = {
                  enable = true;
                  settings.font.size = 16;
                };
              })  
            ];
          };
        })
      ];
  };
    
}
