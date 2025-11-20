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
          auto_insert = true,
        },
      },
    },
    appearance = { nerd_font_variant = 'mono' },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'lazydev', 'copilot' },
      providers = {
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        copilot = { module = 'blink-copilot', name = 'copilot', score_offset = 100, async = true },
      },
    },
    snippets = { preset = 'luasnip' },
    signature = { enabled = true },
    fuzzy = { implementation = 'lua' },
  },
}
