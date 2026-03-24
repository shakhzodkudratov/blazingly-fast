{ pkgs, opsops }:
let
  opsops' = opsops.packages.${pkgs.stdenv.hostPlatform.system}.default;
  opsops-bin = opsops'.overrideAttrs (old: {
    NIX_CFLAGS_COMPILE = (old.NIX_CFLAGS_COMPILE or "") + " -Wno-nonportable-include-path";
  });
in
{
  opsops = opsops-bin;
  opsops-full = pkgs.callPackage ./opsops-full.nix { opsops = opsops-bin; };
  prepare-sops = pkgs.callPackage ./prepare-sops.nix { };
}
