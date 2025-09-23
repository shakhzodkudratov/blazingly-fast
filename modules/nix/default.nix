{
  inputs,
  pkgs,
  ...
}: {
  nix = {
    package = pkgs.nix;

    settings = {
      trusted-users = [
        "@admin"
        "shakhzod"
      ];
      substituters = ["https://cache.nixos.org"];
      trusted-public-keys = ["cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="];
    };

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 30d";
    };

    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

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
      inputs.niri.overlays.niri
    ];
  };
}
