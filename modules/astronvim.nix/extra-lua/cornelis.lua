---@type LazySpec
return {
  {
    -- "isovector/cornelis",
    dir = "{cornelis}",
    name = "cornelis",
    ft = "agda",
    -- build = "stack install",
    version = "*",
    config = function()
      vim.api.nvim_create_autocmd({ "FileType", "BufWritePre" }, {
        pattern = "*.agda,*.lagda.md",
        callback = function() vim.cmd "silent! CornelisLoad" end,
      })
    end,
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = {
          mappings = {
            n = {
              ["<Leader>a"] = { desc = "Agda" },

              -- Global commands
              ["<Leader>al"] = {
                "<Cmd>CornelisLoad<CR>",
                desc = "Load and type-check buffer",
              },
              ["<Leader>a?"] = {
                "<Cmd>CornelisGoals<CR>",
                desc = "Show all goals",
              },
              ["<Leader>aR"] = {
                "<Cmd>CornelisRestart<CR>",
                desc = "Kill and restart the agda process",
              },
              ["<Leader>aA"] = {
                "<Cmd>CornelisAbort<CR>",
                desc = "Abort running command",
              },
              ["<Leader>as"] = {
                "<Cmd>CornelisSolve<CR>",
                desc = "Solve constraints",
              },
              ["<Leader>aD"] = {
                "<Cmd>CornelisGoToDefinition<CR>",
                desc = "Jump to definition of name at cursor",
              },
              ["<Leader>ab"] = {
                "<Cmd>CornelisPrevGoal<CR>",
                desc = "Jump to previous goal",
              },
              ["<Leader>af"] = {
                "<Cmd>CornelisNextGoal<CR>",
                desc = "Jump to next goal",
              },
              -- ["<Leader>a?"] = {
              --   "<Cmd>CornelisInc<CR>",
              --   desc = "Like <C-A> but also targets sub- and superscripts",
              -- },
              -- ["<Leader>a?"] = {
              --   "<Cmd>CornelisDec<CR>",
              --   desc = "Like <C-X> but also targets sub- and superscripts",
              -- },
              ["<Leader>aC"] = {
                "<Cmd>CornelisCloseInfoWindows<CR>",
                desc = "Close (all) info windows cornelis has opened",
              },

              -- Commands in context of a goal
              ["<Leader>a<Leader>"] = {
                "<Cmd>CornelisGive<CR>",
                desc = "Fill goal with hole contents",
              },
              ["<Leader>ar"] = {
                "<Cmd>CornelisRefine<CR>",
                desc = "Refine goal",
              },
              ["<Leader>am"] = {
                "<Cmd>CornelisElaborate<CR>",
                desc = "Fill goal with normalized hole contents",
              },
              ["<Leader>aa"] = {
                "<Cmd>CornelisAuto<CR>",
                desc = "Automatic proof search",
              },
              ["<Leader>ac"] = {
                "<Cmd>CornelisMakeCase<CR>",
                desc = "Case split",
              },
              ["<Leader>a,"] = {
                "<Cmd>CornelisTypeContext<CR>",
                desc = "Show goal type and context",
              },
              ["<Leader>ad"] = {
                "<Cmd>CornelisTypeInfer<CR>",
                desc = "Show inferred type of hole contents",
              },
              ["<Leader>a."] = {
                "<Cmd>CornelisTypeContextInfer<CR>",
                desc = "Show goal type, context, and inferred type of hole contents",
              },
              ["<Leader>an"] = {
                "<Cmd>CornelisNormalize<CR>",
                desc = "Compute normal of hole contents",
              },
              ["<Leader>aw"] = {
                "<Cmd>CornelisWhyInScope<CR>",
                desc = "Show why given name is in scope",
              },
              ["<Leader>ah"] = {
                "<Cmd>CornelisHelperFunc<CR>",
                desc = 'Copy inferred type to register "',
              },
            },
          },
        },
      },
      "neovimhaskell/nvim-hs.vim",
      "kana/vim-textobj-user",
    },
  },
  {
    "hrsh7th/nvim-cmp",
    -- "kdheepak/cmp-latex-symbols"
    dependencies = { "Arkissa/cmp-agda-symbols" },
    opts = function()
      require("cmp").setup.filetype({ "agda", "lagda.md" }, {
        sources = {
          { name = "agda-symbols" },
        },
      })
    end,
  },
}
