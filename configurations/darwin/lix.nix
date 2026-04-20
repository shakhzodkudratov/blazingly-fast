{ inputs, lib, ... }:
{
  imports = [ inputs.lix-module.darwinModules.default ];

  nix = {
    enable = true;
    nixPath = [ ];
    extraOptions = ''
      extra-experimental-features = nix-command flakes
      extra-deprecated-features = or-as-identifier
      nix-path = nixpkgs=flake:nixpkgs
    '';
    settings.trusted-users = [
      "root"
      "@admin"
    ];
    linux-builder = {
      enable = true;
      systems = [ "aarch64-linux" ];
      maxJobs = 8;
      config = {
        virtualisation = {
          cores = lib.mkForce 8;
          memorySize = lib.mkForce 24576;
          diskSize = lib.mkForce 200000;
        };
      };
    };
  };
}
