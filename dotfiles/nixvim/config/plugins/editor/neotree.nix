{ icons, ... }:
{
  plugins.neo-tree = {
    enable = true;
    closeIfLastWindow = true;
    sources = [
      "filesystem"
      "buffers"
      "git_status"
      "document_symbols"
    ];
    popupBorderStyle = "rounded"; # “NC”, “double”, “none”, “rounded”, “shadow”, “single”, “solid” or raw lua code

    filesystem = {
      bindToCwd = false;
      useLibuvFileWatcher = true;
      followCurrentFile.enabled = true;
    };

    defaultComponentConfigs = {
      gitStatus = {
        symbols = {
          added = icons.git.LineAdded;
          conflict = icons.git.FileConflict;
          deleted = icons.git.FileDeleted;
          ignored = icons.git.FileIgnored;
          modified = icons.git.LineModified;
          renamed = icons.git.FileRenamed;
          staged = icons.git.FileStaged;
          unstaged = icons.git.FileUnstaged;
          untracked = icons.git.FileUntracked;
        };
      };
    };

    window.mappings = {
      "<space>" = "none";
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>e";
      action = "<cmd>Neotree toggle<cr>";
      options = {
        silent = true;
        desc = "Toggle explorer";
      };
    }
    {
      mode = "n";
      key = "<leader>o";
      options.desc = "Toggle explorer focus";

      # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/neo-tree.lua#L12-L18
      action.__raw = ''
        function()
          if vim.bo.filetype == "neo-tree" then
            vim.cmd.wincmd "p"
          else
            vim.cmd.Neotree "focus"
          end
        end
      '';
    }
  ];
}
