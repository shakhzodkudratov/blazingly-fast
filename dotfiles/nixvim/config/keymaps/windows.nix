[
  {
    mode = "n";
    key = "<C-Up>";
    action = "<C-w>k";
    options.desc = "Move To Window Up";
  }

  {
    mode = "n";
    key = "<C-Down>";
    action = "<C-w>j";
    options.desc = "Move To Window Down";
  }

  {
    mode = "n";
    key = "<C-Left>";
    action = "<C-w>h";
    options.desc = "Move To Window Left";
  }

  {
    mode = "n";
    key = "<C-Right>";
    action = "<C-w>l";
    options.desc = "Move To Window Right";
  }

  {
    mode = "n";
    key = "<leader>-";
    action = "<C-W>s";
    options = {
      silent = true;
      desc = "Split window below";
    };
  }

  {
    mode = "n";
    key = "<leader>|";
    action = "<C-W>v";
    options = {
      silent = true;
      desc = "Split window right";
    };
  }

  {
    mode = "n";
    key = "<leader>w";
    action = "<cmd>w<cr><esc>";
    options = {
      silent = true;
      desc = "Save file";
    };
  }
]
