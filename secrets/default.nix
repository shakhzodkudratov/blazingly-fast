{ lib, ... }:
{
  sops = {
    defaultSopsFile = /var/secrets/opsops.yaml;
    secrets = import ./opsops.nix;
    age = {
      keyFile = /var/secrets/age-key.txt;
      sshKeyPaths = [ ];
    };
    gnupg = {
      home = lib.mkForce null;
      sshKeyPaths = lib.mkForce [ ];
    };
  };
}
