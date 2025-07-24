return {
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local builtins = require("null-ls").builtins
      opts.sources = require("astrocore").list_insert_unique(opts.sources, {
        builtins.formatting.alejandra,
      })
    end,
  },
}
