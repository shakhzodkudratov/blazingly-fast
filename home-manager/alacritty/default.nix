{ ... }: {
  programs.alacritty = {
    enable = true;
    settings = (builtins.fromTOML (builtins.readFile ./alacritty.toml));
  };
}
