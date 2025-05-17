return {
  name = 'Clang C++ build',
  builder = function()
    local file = vim.fn.expand '%:p'
    local ofile = vim.fn.expand '%:p:r'
    return {
      cmd = { 'clang++' },
      args = { '-std=c++20', '-glldb', '-fstandalone-debug', file, '-o', ofile },
      -- components = { { 'on_output_quickfix', open = true }, 'default' },
    }
  end,
  condition = {
    filetype = { 'cpp' },
  },
}
