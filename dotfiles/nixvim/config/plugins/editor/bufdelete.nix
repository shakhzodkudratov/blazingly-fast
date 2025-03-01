_: {
  plugins.bufdelete.enable = true;

  keymaps = [
    {
      mode = "n";
      key = "<leader>c";
      action = "<cmd>Bdelete<cr>";
      options.desc = "Close buffer";
    }
  ];
}
