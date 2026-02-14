{
  pkgs,
  inputs,
  globalib,
  ...
}:
let
  nmacs = globalib.getPackage pkgs inputs.nmacs "default";
in
{
  home.packages = [ nmacs ];
}
