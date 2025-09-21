pkgs: linux: darwin: other:
if pkgs.stdenv.isLinux
then linux
else if pkgs.stdenv.isDarwin
then darwin
else other
