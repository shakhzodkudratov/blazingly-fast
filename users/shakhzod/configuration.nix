{ pkgs, inputs, outputs, ... }:
{
  users.users.shakhzod = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "input" "uinput" "video"];
    # packages = (with pkgs; [ ]);
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users.shakhzod = import ./home-manager.nix;
  };
}
