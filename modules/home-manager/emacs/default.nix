# thank you, https://github.com/thelissimus/dotfiles
{ pkgs, ... }:
{

  imports = [
    (
      { pkgs, config, ... }:
      let
        emacsPkg = config.programs.emacs.finalPackage;
      in
      {

        home.activation.linkEmacsApp = config.lib.dag.entryAfter [ "writeBoundary" ] ''
          app_src="${emacsPkg}/Applications/Emacs.app"
          app_dst="$HOME/Applications/Nix Apps/Emacs.app"
          mkdir -p "$HOME/Applications/Nix Apps"
          rm -rf "$app_dst"
          ${pkgs.mkalias}/bin/mkalias "$app_src" "$app_dst"
        '';

        programs.zsh.shellAliases.emacsapp = "open ${emacsPkg}/Applications/Emacs.app";
      }
    )
  ];

  # xdg.configFile.emacs = {
  #   source = ./.;
  #   recursive = true;
  # };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-macport;
    extraConfig = ''
      (defconst *config-file* "~/blazingly-fast/modules/home-manager/emacs/config.org")
      (org-babel-load-file *config-file*)
    '';
    extraPackages =
      epkgs:
      with epkgs;
      [
        gruvbox-theme

        meow
        smartparens
        avy
        meow-tree-sitter
        swiper

        dashboard
        nerd-icons
        nerd-icons-dired
        nerd-icons-ibuffer

        wakatime-mode
        pkgs.wakatime-cli
        eat
        claudemacs
        pkgs.claude-code
        perspective
        direnv
        vterm

        nix-mode
        kanata-kbd-mode
      ]
      ++ (
        if pkgs.stdenv.hostPlatform.isLinux then
          [
            pkgs.libvterm
          ]
        else
          [ ]
      );

    # thank you, https://blog.sidhartharya.com/posts/installing-a-custom-emacs-package-in-nix/
    overrides = self: super: {
      # https://github.com/chmouel/kanata-kbd-mode
      kanata-kbd-mode = self.melpaBuild {
        pname = "kanata-kbd-mode";
        version = "0-unstable-2025-09-03";
        src = pkgs.fetchFromGitHub {
          owner = "chmouel";
          repo = "kanata-kbd-mode";
          rev = "0315b567bd61951433c3bdb8e59160d77e1fdcda";
          hash = "sha256-nh62MfmlUGZAW8Mk8ooNoStbSIzAdOhH6PTzqAD8aHs=";
        };
        recipe = pkgs.writeText "recipe" ''
          (kanata-kbd-mode :fetcher github :repo "chmouel/kanata-kbd-mode")
        '';
      };
      # https://github.com/cpoile/claudemacs
      claudemacs = self.melpaBuild {
        pname = "claudemacs";
        version = "0-unstable-2025-12-27";
        src = pkgs.fetchFromGitHub {
          owner = "cpoile";
          repo = "claudemacs";
          rev = "23e6b12bca687060f5de2547ec021bafe395db70";
          hash = "sha256-GI1Zl+/tNQ68JH8fcxouzrc0jW8qFdcyKqsV4wF5H/s=";
        };
        recipe = pkgs.writeText "recipe" ''
          (claudemacs :fetcher github :repo "cpoile/claudemacs")
        '';
      };
    };
  };
}
