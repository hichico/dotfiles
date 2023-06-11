{lib, pkgs, ... }:
  {
    # Bat, a substitute for cat
    programs.bat.enable = true;
    programs.bat.config = {
      style = "plain";
    };

    # Zoxide, a faster way to navigate the filesystem
    programs.zoxide.enable = true;

    # Some packages
    home.packages = lib.attrValues ({

      # Utilities
      inherit(pkgs)
        bandwhich # lightweight session management
        bottom # fancy version of `top` with ASCII graphs
        browsh # in terminal browser
        coreutils
        curl
        fzf # Fuzzy finder
        du-dust # fancy version of `du`
        exa # fancy version of `ls`
        fd # fancy version of `find`
        hyperfine # benchmarking tool
        mosh # wrapper for `ssh` that's better and do not drops connections
        parallel # runs commands in parallel
        ripgrep # better version of `grep`
        tealdeer # rust implementation of `tldr`
        thefuck # fix previous mistakes on the command line
        unrar # extracts RAR files
        upterm # secure terminal sharing
        wget
        xz # extract XZ archives
        helix # Modal editor
        zellij # Terminal multiplexer
        rustup
      ;

      # Development
      inherit (pkgs)
        cloc # source code line counter
        github-copilot-cli
        jq
        nodejs
        typescript
      ;

      # LSP's
      inherit (pkgs)
        nil #Nix
        marksman # Markdown
      ;

      # Node Packages
      inherit (pkgs.nodePackages)
        ts-node
        typescript-language-server
        vscode-langservers-extracted
        yaml-language-server
      ;

      # Useful nix related tools
      inherit(pkgs)
        cachix # adding/managing alternative binary caches hosted by Cachix
        comma # run software without installing it
        nix-output-monitor # get additional information while building packages
        nix-tree # interactively browse dependency graphs of Nix derivations
        nix-update # swiss-knife for updating nix packages
        nixpkgs-review # review pull-requests on nixpkgs
        node2nix # generate Nix expressions to build NPM packages
        statix # lints and suggestions for the Nix programming language
      ;
    });
  }
