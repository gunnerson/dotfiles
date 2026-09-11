return {
  {
    "echasnovski/mini.nvim",
    config = function()
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require("mini.ai").setup { n_lines = 500 }

      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require("mini.surround").setup {
        --   mappings = {
        --     add = "sa", -- Add surrounding in Normal and Visual modes
        --     delete = "sd", -- Delete surrounding
        --     find = "sf", -- Find surrounding (to the right)
        --     find_left = "sF", -- Find surrounding (to the left)
        --     highlight = "sh", -- Highlight surrounding
        --     replace = "sr", -- Replace surrounding
        --
        --     suffix_last = "l", -- Suffix to search with "prev" method
        --     suffix_next = "n", -- Suffix to search with "next" method
        --   },
      }

      require("mini.icons").setup()

      local statusline = require "mini.statusline"
      statusline.setup { use_icons = vim.g.have_nerd_font }

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return "%2l:%-2v"
      end

      require("mini.pairs").setup()

      require("mini.git").setup()

      -- !!! Don't use: buggy
      -- require("mini.diff").setup {
      --   delay = {
      --     text_change = 2000,
      --   },
      --   mappings = {
      --     apply = "",
      --     reset = "",
      --     textobject = "",
      --     goto_first = "",
      --     goto_prev = "",
      --     goto_next = "",
      --     goto_last = "",
      --   },
      -- }
    end,
  },
  { "mg979/vim-visual-multi" },
  -- Use this instead of diff
  -- { "lewis6991/gitsigns.nvim" },
}
