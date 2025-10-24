-- lua/custom/plugins/lsp.lua
return {
  { -- Lua tooling for your config/plugins
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = { library = { { path = '${3rd}/luv/library', words = { 'vim%.uv' } } } },
  },
  {
    'seblyng/roslyn.nvim',
    opts = {
      -- search parent dirs for a solution; great when you open from subfolders
      broad_search = true,
      -- keep false if you switch solutions often; set true to stick to one
      lock_target = true,
    },
  },

  { -- Main LSP + Mason + Fidget, with blink.cmp capabilities
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', opts = { registries = { 'github:mason-org/mason-registry', 'github:Crashdummyy/mason-registry' } } },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'saghen/blink.cmp', -- for capabilities
    },
    config = function()
      -- Diagnostics UI
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(d)
            return d.message
          end,
        },
      } -- mirrors your current setup. :contentReference[oaicite:8]{index=8}

      -- Per-buffer LSP keymaps on attach (your gr* family)
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local tb = require 'telescope.builtin'
          local bufnr = event.buf
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          local map = function(keys, fn, desc, mode)
            vim.keymap.set(mode or 'n', keys, fn, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end
          map('<C-.>', vim.lsp.buf.code_action, 'Code Action', { 'n', 'x' })
          map('<leader>gn', vim.lsp.buf.rename, 'Re[n]ame')
          map('<leader>gr', require('telescope.builtin').lsp_references, 'Goto [R]eferences')
          map('<leader>gi', require('telescope.builtin').lsp_implementations, 'Goto [I]mplementation')
          map('<leader>gd', require('telescope.builtin').lsp_definitions, 'Goto [d]efinition')
          map('<leader>gD', vim.lsp.buf.declaration, 'Goto [D]eclaration')
          map('<leader>gs', require('telescope.builtin').lsp_document_symbols, 'Open Document [S]ymbols')
          map('<leader>gw', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open [W]orkspace Symbols')
          map('<leader>gt', require('telescope.builtin').lsp_type_definitions, 'Goto [T]ype Definition')
          map('<leader>gb', '<C-o>', 'Go [B]ack')
          map('<leader>gf', '<C-i>', 'Go [F]orward')

          -- === CodeLens (shows “N references / implementations / Run test” above symbols) ===
          if client and client.server_capabilities.codeLensProvider then
            local grp = vim.api.nvim_create_augroup('lsp-codelens-' .. bufnr, { clear = true })
            vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
              group = grp,
              buffer = bufnr,
              callback = function()
                vim.lsp.codelens.refresh()
              end,
            })
            -- initial paint
            vim.lsp.codelens.refresh()
          end
        end,
      })

      -- Capabilities from blink.cmp
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      vim.lsp.config('roslyn', {
        settings = {
          -- let Roslyn analyze the whole solution so “Go to …” finds cross-file symbols
          ['csharp|background_analysis'] = {
            dotnet_analyzer_diagnostics_scope = 'fullSolution',
            dotnet_compiler_diagnostics_scope = 'fullSolution',
          },
          ['csharp|code_lens'] = {
            dotnet_enable_references_code_lens = true,
            dotnet_enable_tests_code_lens = true,
          },
          ['csharp|completion'] = {
            dotnet_show_completion_items_from_unimported_namespaces = true,
            dotnet_show_name_completion_suggestions = true,
          },
          ['csharp|inlay_hints'] = {},
        },
      })
      -- Servers list  '
      local servers = {
        rzls = {},
        azure_pipelines_ls = {},
        terraformls = {},
        html = {},
        yamlls = {},
        jsonls = {},
        lua_ls = { settings = { Lua = { completion = { callSnippet = 'Replace' } } } },
      } -- :contentReference[oaicite:11]{index=11}

      -- Ensure tools installed via mason-tool-installer
      local ensure = vim.tbl_keys(servers or {})
      vim.list_extend(ensure, { 'stylua' })
      require('mason-tool-installer').setup { ensure_installed = ensure }

      require('mason-lspconfig').setup {
        ensure_installed = {},
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      } -- mirrors your handler logic. :contentReference[oaicite:12]{index=12}
    end,
  },
}
