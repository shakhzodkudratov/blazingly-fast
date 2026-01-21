pkgs: flake: name:
flake.packages.${pkgs.stdenv.hostPlatform.system}.${name}
