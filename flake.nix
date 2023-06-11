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

    # Other Resources
    comma = { url = "github:Shopify/comma"; flake = false; };

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

    in {

      # My `nix-darwin` configs
      darwinConfigurations = rec {

        # My personal Macbook Pro from 2016
        mbp2016 = darwinSystem {
          system = "x86_64-darwin";
          modules = attrValues self.darwinModules ++ [

            # My main 'nix-darwin' configuration
            ./configuration.nix
            
            # My home-manager module configuration
            home-manager.darwinModules.home-manager {
              nixpkgs = nixpkgsConfig;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.shik0 = import ./home.nix; 
            }
          ];
        };
      };

      # TODO: Overlays
      overlays = {};

      # TODO: Darwin Modules
      darwinModules = {};

      # TODO: Home Manager Modules
      homeManagerModules = {};
    };
}
  