return {
  name = "Clang C build",
  builder = function()
    local file = vim.fn.expand "%:p"
    local ofile = vim.fn.expand "%:p:r"
    return {
      cmd = { "clang" },
      args = {
        "-Wall",
        "-fsanitize=address",
        "-g",
        "-O0",
        "-std=c23",
        "-o",
        ofile,
        file,
        "/home/rumata/dev/hack/compiler.c",
        "/home/rumata/dev/hack/translator.c",
        "/home/rumata/dev/hack/assembler.c",
      },
      -- components = { { 'on_output_quickfix', open = true }, 'default' },
    }
  end,
  condition = {
    filetype = { "c" },
  },
}
