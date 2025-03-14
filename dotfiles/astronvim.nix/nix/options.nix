{ lib, ... }:
{
  options.AstroNvim = with lib; {
    username = mkOption {
      type = types.str;
      description = "The user for whom astronvim.nix will be installed";
    };
    nerdfont = mkOption {
      type = types.str;
      default = "Lilex";
      description = "The Nerd Font to be used";
    };
    nodePackage = mkOption {
      type = types.package;
      defaultText = "nodejs_20";
      description = "The NodeJS version to be used";
    };
    pythonPackage = mkOption {
      type = types.package;
      defaultText = "python311Full";
      description = "The Python version to be used";
    };
  };
}
