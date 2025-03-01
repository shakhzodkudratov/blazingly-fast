{
  plugins.flash = {
    enable = true;
    settings.label.uppercase = false;
  };

  keymaps = [
    {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = "s";
      action = "<cmd>lua require('flash').jump()<cr>";
      options = {
        desc = "Flash";
      };
    }
    #   {
    #     mode = [ "n" "x" "o" ];
    #     key = "S";
    #     action = "<cmd>lua require('flash').treesitter()<cr>";
    #     options = {
    #       desc = "Flash Treesitter";
    #     };
    #   }
    {
      mode = [
        "x"
        "o"
      ];
      key = "R";
      action = "<cmd>lua require('flash').treesitter_search()<cr>";
      options = {
        desc = "Treesitter Search";
      };
    }
  ];
}
