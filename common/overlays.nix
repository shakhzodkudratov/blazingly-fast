{ inputs, ... }:
{
  nix-channels = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
  extra-packages =
    final: _prev:
    let
      pkgs = import inputs.nixpkgs-unstable {
        system = final.system;
        config.allowUnfree = true;
      };
    in
    {
    };
}
