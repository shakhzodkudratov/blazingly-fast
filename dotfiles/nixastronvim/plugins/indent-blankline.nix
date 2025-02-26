# homepage: https://github.com/lukas-reineke/indent-blankline.nvim
# nixvim doc: https://nix-community.github.io/nixvim/plugins/indent-blankline/index.html
_:

{
  rootOpts.colorschemes.gruvbox.settings.integrations.indent_blankline = true;

  # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/indent-blankline.lua#L15-L41
  opts = {
    enable = true;

    settings = {
      indent.char = "▏";

      # Disable scope highlighting
      scope.enabled = false;

      exclude.filetypes = [
        "aerial"
        "alpha"
        "dashboard"
        "lazy"
        "mason"
        "neo-tree"
        "NvimTree"
        "neogitstatus"
        "notify"
        "startify"
        "toggleterm"
        "Trouble"
      ];

      scope = {
        show_start = false;
        show_end = false;
      };
    };
  };
}
