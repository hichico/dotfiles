{pkgs, lib, config, ...}: 

let
  inherit (lib) mkIf;

in
  {
    programs.git.enable = true;
  }
