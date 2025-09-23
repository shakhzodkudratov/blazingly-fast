{lib, ...} @ args: let
  submodules = [
    (import ./alacritty.nix)
    (import ./direnv.nix)
    (import ./floorp.nix)
    (import ./git.nix)
    (import ./niri)
    (import ./starship.nix)
    (import ./zellij.nix)
    (import ./zsh)
    (_: {
      home = {
        enableNixpkgsReleaseCheck = false;
        stateVersion = "25.05";
      };

      # Marked broken Oct 20, 2022 check later to remove this
      # https://github.com/nix-community/home-manager/issues/3344
      # manual.manpages.enable = false;
    })
  ];
in
  builtins.foldl' (a: b: lib.recursiveUpdate a b) {} (builtins.map (x: x args) submodules)
