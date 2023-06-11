{ config, lib, pkgs, ... }:

let
  inherit (lib) elem optionalString;
  inherit (config.home.user-info) nixConfigDirectory;
in {

  programs.fish.enable = true;
  programs.bat.enable = true;
} 
