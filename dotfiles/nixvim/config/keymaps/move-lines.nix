[
  {
    mode = "n";
    key = "<A-Up>";
    action = "<cmd>m .-2<cr>==";
    options.desc = "Move line up";
  }

  {
    mode = "v";
    key = "<A-Up>";
    action = ":m '<-2<cr>gv=gv";
    options.desc = "Move line up";
  }

  {
    mode = "n";
    key = "<A-Down>";
    action = "<cmd>m .+1<cr>==";
    options.desc = "Move line down";
  }

  {
    mode = "v";
    key = "<A-Down>";
    action = ":m '>+1<cr>gv=gv";
    options.desc = "Move line Down";
  }
]
