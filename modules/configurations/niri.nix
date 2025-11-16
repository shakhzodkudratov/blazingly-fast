{pkgs, ...}: {
  # imports = [inputs.niri.nixosModules.niri];

  services = {
    displayManager.sddm.enable = true;
  };

  programs.niri = {
    enable = false;
    package = pkgs.niri-stable;
  };
}
