{ pkgs, ... }:
{
  AstroNvim = {
    username = "shakhzod";
    nerdfont = "JetBrainsMono";
    nodePackage = pkgs.nodejs_22;
    pythonPackage = pkgs.python312Full;
  };
}
