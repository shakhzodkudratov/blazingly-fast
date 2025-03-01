_: {
  globals.mapleader = " ";

  keymaps = 
       (import ./indenting.nix)
    ++ (import ./move-lines.nix)
    ++ (import ./search.nix)
    ++ (import ./session.nix)
    ++ (import ./toggle-options.nix)
    ++ (import ./windows.nix)
    ++ [
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
    ]
    ;

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
