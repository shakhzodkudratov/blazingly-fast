{
  globals.mapleader = " ";

  keymaps = [
    # Windows
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
      key = "<leader>wd";
      action = "<C-W>c";
      options = {
        silent = true;
        desc = "Delete window";
      };
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
      key = "<C-s>";
      action = "<cmd>w<cr><esc>";
      options = {
        silent = true;
        desc = "Save file";
      };
    }

    # Quit/Session
    {
      mode = "n";
      key = "<leader>qq";
      action = "<cmd>quitall<cr><esc>";
      options = {
        silent = true;
        desc = "Quit all";
      };
    }

    # Toggle options
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

    # Move Lines
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

    # Better indenting
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

    # Clear search with ESC
    {
      mode = [
        "n"
        "i"
      ];
      key = "<esc>";
      action = "<cmd>noh<cr><esc>";
      options = {
        silent = true;
        desc = "Escape and clear hlsearch";
      };
    }

    # Paste stuff without saving the deleted word into the buffer
    {
      mode = "x";
      key = "p";
      action = "\"_dP";
      options.desc = "Deletes to void register and paste over";
    }

    # Copy stuff to system clipboard with <leader> + y or just y to have it just in vim
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>y";
      action = "\"+y";
      options.desc = "Copy to system clipboard";
    }

    # Delete to void register
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>D";
      action = "\"_d";
      options.desc = "Delete to void register";
    }
  ];
  extraConfigLua = ''
    function ToggleLineNumber()
    if vim.wo.number then
      vim.wo.number = false
    else
      vim.wo.number = true
      vim.wo.relativenumber = false
      end
    end

    function ToggleRelativeLineNumber()
    if vim.wo.relativenumber then
      vim.wo.relativenumber = false
    else
      vim.wo.relativenumber = true
      vim.wo.number = false
      end
    end

    function ToggleWrap()
        vim.wo.wrap = not vim.wo.wrap
    end

     if vim.lsp.inlay_hint then
       vim.keymap.set('n', '<leader>uh', function()
         vim.lsp.inlay_hint(0, nil)
       end, { desc = 'Toggle Inlay Hints' })
     end
  '';
}
