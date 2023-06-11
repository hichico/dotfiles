{
  description = "My Home Manager flake";

  inputs = {

    # Packages sets from nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-22.11-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Environmens
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs-unstable";

    # System Management
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";

  };

  outputs = { self, nixpkgs, darwin, home-manager, ... } @inputs :
  
    let
      inherit (darwin.lib) darwinSystem;
      inherit (inputs.nixpkgs-unstable.lib) attrValues makeOverridable optionalAttrs singleton;

      # Configuration for 'nixpkgs'
      nixpkgsConfig = {
        config = { allowUnfree = true; };
        overlays = attrValues self.overlays ++ singleton(
        
          # Sub in x86 version of packages that don't build on Apple Silicon
          final: prev: (optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
            inherit (final.pkgs-x86)
              nix-index
              niv;
          })
        );
      };

      homeManagerStateVersion = "23.05";

      primaryUserInfo = {
        username = "shik0";
        fullName = "Chico Pereira";
        email = "olachico@icloud.com";
        nixConfigDirectory = "/Users/shik0/Developer/dotfiles";
      };

      # Modules shared by most `nix-darwin` personal configurations.
      nixDarwinCommonModules = attrValues self.darwinModules ++ [

        # `home-manager` module
        home-manager.darwinModules.home-manager(
          { config, lib, pkgs, ... }:
          let
            inherit (config.users) primaryUser;
          in {
            nixpkgs = nixpkgsConfig;

            # `home-manager` configuration.
            users.users.${primaryUser.username}.home = "/Users/${primaryUser.username}";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${primaryUser.username} = {
              imports = attrValues self.homeManagerModules;
              home.stateVersion = homeManagerStateVersion;
            };

            # Add a registry entry for this flake
            nix.registry.my.flake = self;
          }
        )
      ];

    in {

      # My `nix-darwin` configs
      darwinConfigurations = rec {

        # My personal Macbook Pro from 2016
        mbp2016 = darwinSystem {
          system = "x86_64-darwin";
          modules = nixDarwinCommonModules ++ [
            {
              config.users.primaryUser = primaryUserInfo;
            }
          ];
        };
      };

      # TODO: Overlays
      overlays = {};

      # TODO: Darwin Modules
      darwinModules = {
        general-bootstrap = import ./darwin/bootstrap.nix;
        general-defaults = import ./darwin/defaults.nix;

        # Modules pending upstream
        users-primaryUser = import ./darwin/users.nix;
      };

      # TODO: Home Manager Modules
      homeManagerModules = {
        general-fish = import ./home/fish.nix;
        general-starship = import ./home/starship.nix;
        general-packages = import ./home/packages.nix;
      };
    };
}
  