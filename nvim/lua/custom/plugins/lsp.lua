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
      lock_target = false,
      -- prefer a .sln in the cwd if there are several
      choose_target = function(targets)
        local cwd = vim.loop.cwd()
        for _, t in ipairs(targets) do
          if t:find(cwd, 1, true) then
            return t
          end
        end
        return targets[1]
      end,
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
        end,
      }) -- matches your current init. :contentReference[oaicite:9]{index=9}

      -- Capabilities from blink.cmp
      local capabilities = require('blink.cmp').get_lsp_capabilities() -- same as init.lua. :contentReference[oaicite:10]{index=10}

      vim.lsp.config('roslyn', {
        capabilities = capabilities,
        settings = {
          -- let Roslyn analyze the whole solution so “Go to …” finds cross-file symbols
          ['csharp|background_analysis'] = {
            dotnet_analyzer_diagnostics_scope = 'fullSolution',
            dotnet_compiler_diagnostics_scope = 'fullSolution',
          },
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
