{ pkgs, ... }:
{
  plugins = {
    conform-nvim.settings = {
      formatters_by_ft = {
        sh = [ "shfmt" ];
      };
      formatters = {
        shfmt = {
          command = "${pkgs.shfmt}/bin/shfmt";
        };
      };
    };

    lsp.servers.bashls.enable = true;
  };
}
