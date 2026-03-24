{ pkgs, ... }:
{
  # https://nur.nix-community.org/repos/rycee/
  programs.floorp = {
    enable = true;

    profiles.default = {
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        onepassword-password-manager
        wappalyzer
        sidebery
        wakatimes
        react-devtools
      ];

      settings = {
        "browser.ctrlTab.sortByRecentlyUsed" = true;
        "floorp.browser.tabbar.settings" = 2;
      };
    };
  };
}
