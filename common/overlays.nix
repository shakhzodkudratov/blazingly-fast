{ inputs, ... }: {
  nix-channels = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
  extra-packages = final: _prev: let
    pkgs = import inputs.nixpkgs {
      system = final.system;
      config.allowUnfree = true;
    };
  in {
    nixastronvim = inputs.nixvim.legacyPackages.${final.system}.makeNixvimWithModule {
      inherit pkgs;

      module = ../dotfiles/nixastronvim/.;

      extraSpecialArgs = {
        inherit pkgs;

        icons = import ../dotfiles/nixastronvim/utils/_icons.nix;
      };
    };
  };
}
