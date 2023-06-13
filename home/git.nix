{pkgs, lib, config, ...}: 

let
  inherit (lib) mkIf;

in
  {
    programs.git.enable = true;

    userEmail = config.home.user-info.email;

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
    };
  }
