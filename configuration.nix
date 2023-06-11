{

  services.nix-daemon.enable = true;
  
  users.users.shik0 = {
    name = "shik0";
    home = "/Users/shik0";
  };

  home-manager.users.shik0 = { pkgs, ... }: {
    home.packages = [pkgs.atool pkgs.httpie ];
    programs.fish.enable = true;
  };
}