return {
  name = 'Clean',
  builder = function()
    local file = vim.fn.expand '%:p:r'
    return {
      cmd = { 'rm' },
      args = { file },
    }
  end,
  condition = {
    filetype = { 'c', 'cpp' },
  },
}
