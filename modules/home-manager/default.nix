{ lib, ... }@args:
let
  submodules = builtins.map (x: import x) (lib.folderNixList ./.);
in
builtins.foldl' (a: b: lib.recursiveUpdate a b) { } (builtins.map (x: x args) submodules)
