string : set : let
  keys = builtins.map (key: "{${key}}") (builtins.attrNames set);
  values = builtins.map (value: "${value}") (builtins.attrValues set);
in
  builtins.replaceStrings keys values string
