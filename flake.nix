{
  descriotion = "Chico's darwin system"

  inputs {
    # Package sets
    nixpkgs.url = "github:nixos/nixpkgs-22.11-darwin";
    nixpkgs-unstable.url = github:NixOS/nixpkgs/nixpkgs-unstable;
    # Environment / System Management
    darwin = {
      
    };
    home-manager = {
      
    }
    
  };

  outputs = inputs @ {self, darwin, nixpkgs, home-manager, ... }; 
}