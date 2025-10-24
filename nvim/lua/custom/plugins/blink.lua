-- lua/custom/plugins/blink.lua
-- Completion
return {
  'saghen/blink.cmp',
  event = 'VimEnter',
  version = '1.*',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      opts = {},
      build = (function()
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
    },
    'folke/lazydev.nvim',
    'fang2hou/blink-copilot',
  },

  opts = {
    -- Super-Tab: <Tab> accepts completion OR jumps snippet, else inserts a tab.
    keymap = {
      preset = 'super-tab',
      -- keep Enter too so you can accept with <CR> when no menu is open
      ['<CR>'] = { 'accept', 'fallback' },
    },

    -- Make Super-Tab play nice with snippets:
    -- when a snippet is active, don't auto-preselect completion items
    completion = {
      list = {
        selection = {
          preselect = function()
            return not require('blink.cmp').snippet_active { direction = 1 }
          end,
          -- auto_insert can stay true; preselect() above gates it during snippets
          auto_insert = true,
        },
      },
      -- (Optional alternative): instead of the preselect() trick above,
      -- you can disable showing the menu inside snippets:
      -- trigger = { show_in_snippet = false },
    },

    -- keep your other blink settings as-is…
    appearance = { nerd_font_variant = 'mono' },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'lazydev' },
      providers = { lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 } },
    },
    snippets = { preset = 'luasnip' },
    signature = { enabled = true },
    fuzzy = { implementation = 'lua' },
  },
}
