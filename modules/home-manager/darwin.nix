{ lib, isDarwin, ... }:
lib.mkMerge [
  (lib.optionalAttrs isDarwin {
    home.activation.linkApplications = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ln -sfn "$HOME/.nix-profile/Applications" "$HOME/Applications/Nix Apps"
    '';
  })
]
