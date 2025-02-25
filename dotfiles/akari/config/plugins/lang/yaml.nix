{
  plugins.lsp.servers.yamlls = {
    enable = true;
    extraOptions = {
      capabilities = {
        textDocument = {
          foldingRange = {
            dynamicRegistration = false;
            lineFoldingOnly = true;
          };
        };
      };
    };
  };
}
