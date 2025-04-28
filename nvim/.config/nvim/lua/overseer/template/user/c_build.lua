return {
  name = "Clang C build",
  builder = function()
    local file = vim.fn.expand "%:p"
    local ofile = vim.fn.expand "%:p:r"
    return {
      cmd = { "clang" },
      args = { "-Wall", "-std=c23", "-fsanitize=address", "-g", "-o", ofile, file },
      -- components = { { "on_output_quickfix", open = true }, "default" },
    }
  end,
  condition = {
    filetype = { "c" },
  },
}
