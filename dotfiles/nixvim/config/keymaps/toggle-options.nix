[
  {
    mode = "n";
    key = "<leader>ul";
    action = ":lua ToggleLineNumber()<cr>";
    options = {
      silent = true;
      desc = "Toggle Line Numbers";
    };
  }

  {
    mode = "n";
    key = "<leader>uL";
    action = ":lua ToggleRelativeLineNumber()<cr>";
    options = {
      silent = true;
      desc = "Toggle Relative Line Numbers";
    };
  }

  {
    mode = "n";
    key = "<leader>uw";
    action = ":lua ToggleWrap()<cr>";
    options = {
      silent = true;
      desc = "Toggle Line Wrap";
    };
  }
]
