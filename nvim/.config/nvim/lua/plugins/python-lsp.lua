return {
  {
    -- https://github.com/mfussenegger/nvim-dap-python
    'mfussenegger/nvim-dap-python',
    ft = 'python',
    dependencies = {
      -- https://github.com/mfussenegger/nvim-dap
      'mfussenegger/nvim-dap',
      'rcarriga/nvim-dap-ui',
    },
    config = function()
      -- Update the path passed to setup to point to your system or virtual env python binary
      require('dap-python').setup '/usr/bin/python'
    end,
  },
  {
    'psf/black',
    ft = 'python',
    config = function()
      -- Automatically format file buffer when saving
      vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
        pattern = '*.py',
        callback = function()
          vim.cmd 'Black'
        end,
      })
    end,
  },
  {
    'nvimtools/none-ls.nvim',
    config = function()
      require('null-ls').setup {
        sources = {
          require('null-ls').builtins.formatting.black,
          -- require('null-ls').builtins.diagnostics.mypy.with {
          --   extra_args = function()
          --     local virtual = os.getenv 'VIRTUAL_ENV' or os.getenv 'CONDA_PREFIX' or '/usr'
          --     return { '--python-executable', virtual .. '/bin/python' }
          --   end,
          -- },
        },
      }
    end,
    requires = { 'nvim-lua/plenary.nvim' },
  },
}
