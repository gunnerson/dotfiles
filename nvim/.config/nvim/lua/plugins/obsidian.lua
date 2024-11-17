return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    workspaces = {
      {
        name = 'personal',
        path = '~/vaults/personal',
      },
    },
    notes_subdir = 'inbox',
    new_notes_location = 'notes_subdir',
    disable_frontmatter = true,
    templates = {
      subdir = 'templates',
      date_format = '%Y-%m-%d',
      time_format = '%H:%M:%S',
    },
    completion = {
      nvim_cmp = false,
      min_chars = 2,
    },
  },
}
