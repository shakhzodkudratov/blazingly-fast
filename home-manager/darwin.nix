{ lib, isDarwin, ... }:
lib.mkIf isDarwin {
  home.activation.linkApplications = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ln -sfn "$HOME/.nix-profile/Applications" "$HOME/Applications/Nix Apps"
  '';
}
