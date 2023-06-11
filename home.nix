{ config, pkgs, lib, ... }:

{
  home.username = "shik0";
  home.homeDirectory = "/Users/shik0";
  home.stateVersion = "23.05";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    coreutils
    bat
    nodejs
  ];
}
