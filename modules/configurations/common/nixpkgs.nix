{ inputs, ... }:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = false;
      allowInsecure = false;
      allowUnsupportedSystem = false;
    };

    overlays = [
      inputs.nur.overlays.default
    ];
  };
}
