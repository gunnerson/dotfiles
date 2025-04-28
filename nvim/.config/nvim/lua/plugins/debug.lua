return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",
    {
      "mfussenegger/nvim-dap-python",
      ft = "python",
      config = function()
        require("dap-python").setup "/usr/bin/python"
      end,
    },
    {
      "stevearc/overseer.nvim",
      opts = {},
    },
    "theHamsta/nvim-dap-virtual-text",
  },
  keys = function(_, keys)
    local dap = require "dap"
    local dapui = require "dapui"
    return {
      { "<F5>", dap.continue, desc = "Debug: Start/Continue" },
      { "<F1>", dap.step_into, desc = "Debug: Step Into" },
      { "<F2>", dap.step_over, desc = "Debug: Step Over" },
      { "<F3>", dap.step_out, desc = "Debug: Step Out" },
      { "<leader>cb", dap.toggle_breakpoint, desc = "Debug: Toggle Breakpoint" },
      {
        "<leader>cB",
        function()
          dap.set_breakpoint(vim.fn.input "Breakpoint condition: ")
        end,
        desc = "Debug: Set Breakpoint",
      },
      { "<F7>", dapui.toggle, desc = "Debug: See last session result." },
      {
        "<leader>c?",
        function()
          dapui.eval(nil, { enter = true })
        end,
        desc = "Eval var under cursor",
      },
      unpack(keys),
    }
  end,
  config = function()
    local dap = require "dap"
    local dapui = require "dapui"
    local mason_registry = require "mason-registry"
    local codelldb = mason_registry.get_package("codelldb"):get_install_path() .. "/codelldb"

    require("mason-nvim-dap").setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        "stylua",
        "python",
        "codelldb",
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    ---@diagnostic disable-next-line: missing-fields
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
      -- controls = {
      --   icons = {
      --     pause = '⏸',
      --     play = '▶',
      --     step_into = '⏎',
      --     step_over = '⏭',
      --     step_out = '⏮',
      --     step_back = 'b',
      --     run_last = '▶▶',
      --     terminate = '⏹',
      --     disconnect = '⏏',
      --   },
      -- },
    }

    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close

    require("nvim-dap-virtual-text").setup()

    -- C/C++, Rust
    require("overseer").setup {
      templates = { "builtin", "user.c_build", "user.cpp_build", "user.c_clean" },
    }
    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = vim.fn.expand(codelldb),
        args = { "--port", "${port}" },
      },
    }
    dap.configurations.c = {
      {
        name = "C",
        type = "codelldb",
        request = "launch",
        cwd = "${workspaceFolder}",
        program = "${workspaceFolder}/${fileBasenameNoExtension}",
        preLaunchTask = "Clang C build",
        postDebugTask = "Clean",
        stopOnEntry = false,
      },
    }
    dap.configurations.cpp = {
      {
        name = "C++",
        type = "codelldb",
        request = "launch",
        cwd = "${workspaceFolder}",
        program = "${workspaceFolder}/${fileBasenameNoExtension}",
        preLaunchTask = "Clang C++ build",
        postDebugTask = "Clean",
        stopOnEntry = false,
      },
    }
  end,
}
