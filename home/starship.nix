{
  # Starship Prompt
  programs.starship.enable = true;

  programs.starship.settings = {
    directory.fish_style_pwd_dir_length = 1; # turn on fish directory truncation
    directory.truncation_length = 2; # number of directories not to truncate
    gcloud.disabled = true; # annoying to always have on
    hostname.style = "bold green";
    memory_usage.disabled = true; # because it includes cached memory it's reported as full a lot
    username.style_user = "bold blue";
    package.disabled = true;
    nodejs.disabled = true;
    rust.disabled = true;
    ruby.disabled = true;
  };
}
