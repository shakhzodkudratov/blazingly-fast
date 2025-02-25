{ pkgs, lib, ... }:
{
  plugins = {
    conform-nvim.settings = {
      formatters_by_ft.html = [
        "prettierd"
        "prettier"
      ];

      formatters = {
        prettierd.command = "${pkgs.prettierd}/bin/prettierd";
        prettier.command = "${pkgs.nodePackages.prettier}/bin/prettier";
      };
    };

    lsp = {
      servers = {
        html = {
          enable = true;
          cmd = [
            "${pkgs.vscode-langservers-extracted}/bin/vscode-html-language-server"
            "--stdio"
          ];
        };
      };

      enabledServers = [
        {
          name = "emmet_language_server";
          extraOptions = {
            cmd = [
              (lib.getExe pkgs.emmet-language-server)
              "--stdio"
            ];
            filetypes = [ "html" ];
          };
        }
      ];
    };
  };
}
