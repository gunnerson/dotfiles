return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("harpoon"):setup()
  end,
  keys = {
    {
      "<leader>ha",
      function()
        require("harpoon"):list():add()
      end,
      desc = "harpoon file",
    },
    {
      "<leader>hh",
      function()
        local harpoon = require "harpoon"
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = "harpoon quick menu",
    },
    {
      "<C-1>",
      function()
        require("harpoon"):list():select(1)
      end,
      desc = "harpoon to file 1",
    },
    {
      "<C-2>",
      function()
        require("harpoon"):list():select(2)
      end,
      desc = "harpoon to file 2",
    },
    {
      "<C-3>",
      function()
        require("harpoon"):list():select(3)
      end,
      desc = "harpoon to file 3",
    },
    {
      "<C-4>",
      function()
        require("harpoon"):list():select(4)
      end,
      desc = "harpoon to file 4",
    },
    {
      "<C-5>",
      function()
        require("harpoon"):list():select(5)
      end,
      desc = "harpoon to file 5",
    },
    {
      "<C-6>",
      function()
        require("harpoon"):list():select(6)
      end,
      desc = "harpoon to file 6",
    },
    {
      "<C-7>",
      function()
        require("harpoon"):list():select(7)
      end,
      desc = "harpoon to file 7",
    },
    {
      "<C-8>",
      function()
        require("harpoon"):list():select(8)
      end,
      desc = "harpoon to file 8",
    },
    {
      "<C-9>",
      function()
        require("harpoon"):list():select(9)
      end,
      desc = "harpoon to file 9",
    },
    {
      "<C-0>",
      function()
        require("harpoon"):list():select(0)
      end,
      desc = "harpoon to file 10",
    },
  },
}
