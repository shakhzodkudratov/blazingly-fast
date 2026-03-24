{ inputs, ... }:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = false;
      allowInsecure = false;
      allowUnsupportedSystem = true;
    };

    overlays = [
      inputs.nur.overlays.default
      inputs.nix-doom-emacs-unstraightened.overlays.default
      # direnv: CGO needed for -linkmode=external on darwin
      (_final: prev: {
        direnv = prev.direnv.overrideAttrs (old: {
          env = (old.env or { }) // {
            CGO_ENABLED = "1";
          };
        });
      })
      # # https://github.com/NixOS/nixpkgs/pull/476848
      # (_final: prev: {
      #   pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
      #     (_pySelf: pySuper: {
      #       pyxattr = pySuper.pyxattr.overridePythonAttrs (old: {
      #         buildInputs = prev.lib.optional
      #           (prev.lib.meta.availableOn prev.stdenv.buildPlatform prev.attr)
      #           prev.attr;
      #         meta = old.meta // {
      #           platforms = prev.lib.platforms.linux ++ prev.lib.platforms.darwin;
      #         };
      #       });
      #     })
      #   ];
      # })
    ];
  };
}
