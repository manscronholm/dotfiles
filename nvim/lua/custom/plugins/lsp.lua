-- lua/custom/plugins/lsp.lua
return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = { library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } } },
  },
  {
    "seblyng/roslyn.nvim",
    opts = { broad_search = true, lock_target = true },
    config = function(_, opts)
      require("roslyn").setup(opts)
      -- Customize Roslyn with the new API (optional)
      vim.lsp.config("roslyn", {
        settings = {
          ["csharp|background_analysis"] = {
            dotnet_analyzer_diagnostics_scope = "fullSolution",
            dotnet_compiler_diagnostics_scope = "fullSolution",
          },
          ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
            dotnet_enable_tests_code_lens = true,
          },
          ["csharp|completion"] = {
            dotnet_show_completion_items_from_unimported_namespaces = true,
            dotnet_show_name_completion_suggestions = true,
          },
        },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "saghen/blink.cmp",
      "tris203/rzls.nvim",
    },
    config = function()
      -- Diagnostics UI (kept from your setup)
      vim.diagnostic.config({
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
        underline = true,
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
          },
        } or {},
        virtual_text = {
          source = "if_many",
          spacing = 2,
          format = function(d)
            return d.message
          end,
        },
      })

      -- One place to bind your “goto/refs/…” keys for all languages
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
        callback = function(ev)
          local bufnr = ev.buf
          local tb = require("telescope.builtin")
          local function map(lhs, rhs, desc, mode)
            vim.keymap.set(mode or "n", lhs, rhs, { buffer = bufnr, desc = "LSP: " .. desc })
          end

          -- Keymaps
          map("<leader>gd", tb.lsp_definitions, "Goto [d]efinition")
          map("<leader>gi", tb.lsp_implementations, "Goto [I]mplementation")
          map("<leader>gr", tb.lsp_references, "Goto [R]eferences")
          map("<leader>gt", tb.lsp_type_definitions, "Goto [T]ype Definition")
          map("<leader>gs", tb.lsp_document_symbols, "Document [S]ymbols")
          map("<leader>gw", tb.lsp_dynamic_workspace_symbols, "[W]orkspace Symbols")
          map("<leader>gb", "<C-o>", "Go [B]ack")
          map("<leader>gf", "<C-i>", "Go [F]orward")
          map("<leader>.", vim.lsp.buf.code_action, "Code action", { "n", "v" })

          -- Keep your codelens refresh logic
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if client and client.server_capabilities.codeLensProvider then
            local grp = vim.api.nvim_create_augroup("lsp-codelens-" .. bufnr, { clear = true })
            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
              group = grp,
              buffer = bufnr,
              callback = vim.lsp.codelens.refresh,
            })
            vim.lsp.codelens.refresh()
          end
        end,
      })

      local capabilities = require("blink.cmp").get_lsp_capabilities()

      local servers = {
        terraformls = {},
        azure_pipelines_ls = {},
        bicep = {},
        bash = {},
        html = {},
        yamlls = {},
        jsonls = {},
        lua_ls = { settings = { Lua = { completion = { callSnippet = "Replace" } } } },
        rzls = {},
      }

      for name, cfg in pairs(servers) do
        -- 1) customize/extend the server config
        vim.lsp.config(
          name,
          vim.tbl_deep_extend("force", {
            capabilities = capabilities,
          }, cfg)
        )

        -- 2) enable it for its filetypes
        vim.lsp.enable(name)
      end
    end,
  },
}
