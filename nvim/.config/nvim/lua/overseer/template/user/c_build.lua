return {
  name = "Clang C build",
  builder = function()
    local file = vim.fn.expand "%:p"
    local ofile = vim.fn.expand "%:p:r"
    return {
      cmd = { "clang" },
      args = { "-Wall", "-fsanitize=address", "-g", "-std=c23", "-o", ofile, file },
      -- components = { { 'on_output_quickfix', open = true }, 'default' },
    }
  end,
  condition = {
    filetype = { "c" },
  },
}
