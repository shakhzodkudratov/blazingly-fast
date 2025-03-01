{
  plugins.debugprint = {
    enable = true;

    settings = {
      commands = {
        toggle_comment_debug_prints = "ToggleCommentDebugPrints";
        delete_debug_prints = "DeleteDebugPrints";
      };

      display_counter = true;
      display_snippet = true;

      keymaps = {
        normal = {
          plain_below = "<leader>pb";
          plain_above = "<leader>pB";
          variable_below = "<leader>pv";
          variable_above = "<leader>pV";
          variable_below_alwaysprompt.__raw = "nil";
          variable_above_alwaysprompt.__raw = "nil";
          textobj_below = "<leader>po";
          textobj_above = "<leader>pO";
          toggle_comment_debug_prints.__raw = "nil";
          delete_debug_prints.__raw = "nil";
        };
        visual = {
          variable_below = "<leader>pv";
          variable_above = "<leader>pV";
        };
      };
    };
  };
}
