{ outputs, ... }:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };

    overlays = [
      outputs.overlays.nix-channels
      outputs.overlays.extra-packages
    ];
  };
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
}
