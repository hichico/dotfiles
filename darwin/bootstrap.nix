{ config, lib, pkgs, ...} :

{
  # Nix Configuration ----------------------------------------------------

  nix.settings = {
  
    substituters = [
      "https://cache.nixos.org/"
      "https://malo.cachix.org"
    ];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "malo.cachix.org-1:fJL4+lpyMs/1cdZ23nPQXArGj8AS7x9U67O8rMkkMIo="
    ];

    trusted-users = [ "@admin" ];
  };

  experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixConfigBuildUsers = true;

  # Auto upgrade nix package and the daemon service
  services.nix-daemon.enable = true;
}
