{
  plugins = {
    lsp-signature.enable = true;
    fidget.enable = true;

    lsp = {
      enable = true;
      servers.typos_lsp.enable = true;
      keymaps.lspBuf = {
        "<c-k>" = "signature_help";
        "gi" = "implementation";
      };
    };
    lint.enable = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>ll";
      action = "<cmd>LspInfo<cr>";
      options.desc = "Lsp Info";
    }
  ];
}
