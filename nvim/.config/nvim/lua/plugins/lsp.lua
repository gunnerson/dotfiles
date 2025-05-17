return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    { "j-hui/fidget.nvim", opts = {} },
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "luvit-meta/library", words = { "vim%.uv" } },
        },
      },
    },
    { "Bilal2453/luvit-meta", lazy = true },
    "saghen/blink.cmp",
  },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end
        map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
        map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
        map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
        map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
        map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
        map("<leader>j", "<cmd>lua vim.lsp.buf.hover()<CR>", "Show hover information")
        map("<leader>cj", "<cmd>lua vim.diagnostic.open_float()<CR>", "Show diagnostic in float")
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })
          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = "kickstart-lsp-highlight", buffer = event2.buf }
            end,
          })
        end
        vim.api.nvim_create_autocmd("LspAttach", {
          group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
          callback = function()
            if client == nil then
              return
            end
            if client.name == "ruff" then
              client.server_capabilities.hoverProvider = false
            end
          end,
          desc = "LSP: Disable hover capability from Ruff",
        })
        vim.api.nvim_create_user_command("DiagnosticToggle", function()
          local config = vim.diagnostic.config
          local vt = config().virtual_text
          config {
            virtual_text = not vt,
            underline = not vt,
            signs = not vt,
          }
        end, { desc = "toggle diagnostic" })
        -- vim.api.nvim_create_autocmd("BufWritePre", {
        --   callback = function()
        --     if client == nil then
        --       return
        --     end
        --     if client.name == "ruff" then
        --       vim.lsp.buf.code_action { context = { only = { "source.organizeImports" } }, apply = true }
        --     end
        --   end,
        --   buffer = event.buffer,
        -- })
      end,
    })

    local servers = {
      -- clangd = {
      --   cmd = { "clangd", "--completion-style=detailed" },
      --   on_attach = function()
      --     vim.keymap.set("n", "<A-o>", "<CMD>ClangdSwitchSourceHeader<CR>", { buffer = 0 })
      --   end,
      -- },
      -- pyright = {
      --   settings = {
      --     pyright = {
      --       -- disableOrganizeImports = true,
      --     },
      --     -- python = {
      --     --   analysis = {
      --     --     ignore = { "*" },
      --     --   },
      --     -- },
      --   },
      -- },
      -- ruff = {
      --   init_options = {
      --     settings = {
      --       lint = {
      --         enable = false,
      --         args = {
      --           "--ignore=F403,",
      --         },
      --       },
      --     },
      --   },
      -- },
      -- html = {},
      -- emmet_language_server = {},
      -- bashls = {
      --   filetypes = { "sh", "zsh" },
      -- },
      -- yamlls = {},
      -- tailwindcss = {},
      -- dockerls = {},
      -- prettierd = {},
      vhdl_ls = {},
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            diagnostics = { disable = { "missing-fields" } },
          },
        },
      },
    }

    require("mason").setup()
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      "stylua",
      -- "shfmt",
      -- "codelldb",
      -- "clang-format",
    })
    require("mason-tool-installer").setup { ensure_installed = ensure_installed }
    ---@diagnostic disable-next-line: missing-fields
    require("mason-lspconfig").setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = require("blink.cmp").get_lsp_capabilities()
          require("lspconfig")[server_name].setup(server)
        end,
      },
    }
  end,
}
