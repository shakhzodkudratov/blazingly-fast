{ inputs, pkgs, ... }:
{
  environment.systemPackages =
    let
      kmonad = inputs.kmonad.packages."${pkgs.stdenv.hostPlatform.system}".default;
    in
    [
      kmonad
      (pkgs.writeScriptBin "kmonad-keychron" ''
        sudo ${kmonad}/bin/kmonad ${./keychron-k3-max.kbd}
      '')
    ];
}
