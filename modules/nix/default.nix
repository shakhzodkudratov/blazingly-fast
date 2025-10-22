{
  inputs,
  # pkgs,
  ...
}: {
  nix = {
    # package = pkgs.nix;

    settings = {
      trusted-users = [
        "@admin"
        "shakhzod"
      ];
      substituters = ["https://cache.nixos.org" "https://install.determinate.systems"];
      trusted-public-keys = ["cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" "cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM="];
    };

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 30d";
    };

    extraOptions = ''
      experimental-features = nix-command flakes pipe-operators
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
