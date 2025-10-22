path: let
  matchToBool = match: match != null;
  endsWithNix = name: matchToBool (builtins.match "(.+\.nix$)" name);
  attrToList = attrset:
    builtins.map (name: {
      inherit name;
      value = attrset."${name}";
    }) (builtins.attrNames attrset);
  isNotDefaultNixFile = {
    name,
    value,
  }:
    name != "default.nix" && endsWithNix name && value == "regular";
  isDirectoryWithDefaultNix = {
    name,
    value,
  }:
    value == "directory" && builtins.pathExists "${path}/${name}/default.nix";

  readDir = path: attrToList (builtins.readDir path);
  filter = builtins.filter (f: (isNotDefaultNixFile f) || (isDirectoryWithDefaultNix f));
  map = builtins.map (f: "${path}/${f.name}");
in
  map (filter (readDir path))
