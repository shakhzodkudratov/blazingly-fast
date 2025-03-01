{ inputs, ... }: {
  nix-channels = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
  extra-packages = final: _prev: let
    pkgs = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  in {
    nixvim = inputs.nixvim.legacyPackages.${final.system}.makeNixvimWithModule {
      inherit pkgs;

      module = ../dotfiles/nixvim/config;

      extraSpecialArgs = {
        inherit pkgs;
        inherit inputs;
      } // import ../dotfiles/nixvim/lib { inherit pkgs; };
    };
  };
}
