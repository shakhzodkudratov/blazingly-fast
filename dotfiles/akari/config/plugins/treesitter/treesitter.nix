{
  plugins = {
    treesitter = {
      enable = true;
      settings = {
        highlight.enable = true;
        incremental_selection.enable = true;
        indent.enable = true;
      };
      nixvimInjections = true;
    };
    treesitter-context.enable = true;
  };
}
