{ ... }: {
  programs.topgrade = {
    enable = true;
    settings = {
      misc = {
        assume_yes = true;
        disable = [
          "nix"
          "bun"
          "node"
          "pnpm"
          "yarn"
          "home_manager"
          "vscode"
        ];
      };
      commands = {
        "Nix" = "nix-channel --update && nix-env -u '*'";
        "Home Manager" = "home-manager switch --flake github:shakhzodkudratov/blazingly-fast";
      };
    };
  };
}
