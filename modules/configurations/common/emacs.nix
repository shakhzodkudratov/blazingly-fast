{ inputs, pkgs, ... }:
let
  nmacs = inputs.nmacs.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  environment.systemPackages = [ nmacs ];
}
