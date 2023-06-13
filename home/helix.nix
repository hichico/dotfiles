{
  # Helix editor
  programs.helix.enable = true;

  # Settings configurations
  programs.helix.settings = {
    theme = "tokyonight";

    editor = {
      line-number = "relative";
      lsp.display-messages = true;
      auto-format = true;
      cursor-shape = {        
        insert = "bar";
        normal = "block";
        select = "underline";
      };

    };
  };
}
