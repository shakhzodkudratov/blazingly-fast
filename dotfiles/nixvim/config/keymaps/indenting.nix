[
  {
    mode = "v";
    key = "<";
    action = "<gv";
  }

  {
    mode = "v";
    key = ">";
    action = ">gv";
  }

  {
    mode = "i";
    key = "<C-a>";
    action = "<cmd> norm! ggVG<cr>";
    options.desc = "Select all lines in buffer";
  }

  {
    mode = "n";
    key = "J";
    action = "mzJ`z";
    options.desc = "Allow cursor to stay in the same place after appending to current line ";
  }

  # {
  #   mode = "n";
  #   key = "<C-d>";
  #   action = "<C-d>zz";
  #   options.desc = "Allow C-d and C-u to keep the cursor in the middle";
  # }
  #
  # {
  #   mode = "n";
  #   key = "<C-u>";
  #   action = "<C-u>zz";
  #   options.desc = "Allow C-d and C-u to keep the cursor in the middle";
  # }

  {
    mode = "n";
    key = "n";
    action = "nzzzv";
    options.desc = "Allow search terms to stay in the middle";
  }

  {
    mode = "n";
    key = "N";
    action = "Nzzzv";
    options.desc = "Allow search terms to stay in the middle";
  }
]
