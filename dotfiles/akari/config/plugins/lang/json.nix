{ pkgs, ... }:
{
  plugins = {
    conform-nvim.settings = {
      formatters_by_ft = {
        json = [ "jq" ];
      };

      formatters = {
        jq = {
          command = "${pkgs.jq}/bin/jq";
        };
      };
    };

    lint = {
      lintersByFt = {
        json = [ "jsonlint" ];
      };

      linters = {
        jsonlint = {
          cmd = "${pkgs.nodePackages_latest.jsonlint}/bin/jsonlint";
        };
      };
    };

    lsp.servers.jsonls = {
      enable = true;
    };
  };
}
