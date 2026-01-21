{ inputs, ... }:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
      allowInsecure = false;
      allowUnsupportedSystem = true;
      android_sdk.accept_license = true;
    };

    overlays = [
      inputs.nur.overlays.default
    ];
  };
}
