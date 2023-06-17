{pkgs, lib, config, ...}: 

let
  inherit (lib) mkIf;

in
  {
    programs.git = {
    
      enable = true;

      # Enhanced diffs
      delta.enable = true;

      ignores = [
        "*~"
        "*.swp"
        ".DS_Store"
      ];

      extraConfig = {
        init.defaultBranch = "main";
        core.editor = "helix";
        diff.colorMoved = "default";
        pull.rebase = true;

        # For supercede
        core.symlinks = true;

        # Automatically set uptream
        push.autoSetupRemote = true;

        # Aliases
        aliases = {
          a = "add";
          aa = "add --all";
          pl = "pull";
          pu = "push";
          puf = "push --force";
          s = "status";
        };
      };
    };
  }
