{ pkgs, inputs, outputs, ... }: let
    globalPackages = import ../global/packages.nix { inherit pkgs; };
in {
  users.users = {
    shakhzod = {
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" ];
      packages = (with pkgs; [
      ]) ++ globalPackages;
    };
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = { shakhzod = import ./home.nix; };
  };
}
