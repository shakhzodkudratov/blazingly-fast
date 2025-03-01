_: {
  plugins.comment = {
    enable = true;
    settings.pre_hook = "require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()";
  };

  extraConfigLua = ''
    require('Comment').setup({
      mappings = {
        basic = false,
        extra = false,
      },
    })
  '';

  # https://github.com/AstroNvim/AstroNvim/blob/main/lua/astronvim/plugins/comment.lua#L20
  keymaps = [
    {
      mode = "n";
      key = "<leader>/";
      action.__raw = ''
        function()
          return require("Comment.api").call(
            "toggle.linewise." .. (vim.v.count == 0 and "current" or "count_repeat"),
            "g@$"
          )()
        end
      '';
      options = {
        unique = true;
        expr = true;
        desc = "Toggle comment line";
      };
    }
    {
      mode = "x";
      key = "<leader>/";
      action = "<esc><cmd>lua require('Comment.api').locked('toggle.linewise')(vim.fn.visualmode())<cr>";
      options.desc = "Toggle comment";
    }
  ];
}
