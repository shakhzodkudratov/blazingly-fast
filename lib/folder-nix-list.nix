path:
let
  entries = builtins.readDir path;
  names = builtins.attrNames entries;
  isImportable =
    name:
    let
      type = entries.${name};
      len = builtins.stringLength name;
    in
    builtins.substring 0 1 name != "_"
    && (
      (type == "regular" && name != "default.nix" && builtins.substring (len - 4) 4 name == ".nix")
      || (type == "directory" && builtins.pathExists "${path}/${name}/default.nix")
    );
in
map (name: "${path}/${name}") (builtins.filter isImportable names)
