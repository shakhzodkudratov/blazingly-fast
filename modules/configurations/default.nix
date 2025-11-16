{lib, ...}: {
  imports =
    builtins.map (x: import x) (lib.folderNixList ./.);
}
