{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.kanata
    (pkgs.writeScriptBin "kanata-gallium" ''
      sudo ${pkgs.kanata}/bin/kanata -c ${./keyboard.kbd}
    '')
  ];
}
