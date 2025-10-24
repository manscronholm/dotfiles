-- lua/custom/plugins/barbar.lua
return {
  'romgrk/barbar.nvim',
  version = '*',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- icons for the tabline
  },
  init = function()
    -- If you ever want to call setup() yourself before Lazy config runs:
    -- vim.g.barbar_auto_setup = false
  end,
  opts = {
    animation = true,
    insert_at_end = true,
    maximum_padding = 2,
    icons = {
      buffer_index = true,
      buffer_number = false,
      button = '✕',
      inactive = { separator = { left = ' ', right = ' ' } },
    },
    sidebar_filetypes = {
      -- keeps tabline aligned when these sidebars are open
      ['neo-tree'] = true,
      aerial = { event = 'BufWinLeave' },
    },
  },
  config = function(_, opts)
    require('barbar').setup(opts)

    local map = function(lhs, rhs, desc)
      vim.keymap.set('n', lhs, rhs, { desc = desc, silent = true })
    end

    -- ——— Navigate buffers (keeps your Alt-n/p for real tabs) ———
    map('<A-,>', '<Cmd>BufferPrevious<CR>', 'Buffer: Previous')
    map('<A-.>', '<Cmd>BufferNext<CR>', 'Buffer: Next')

    -- Move buffers in the list (Alt+Arrow to avoid Alt-h/l clash)
    map('<A-Left>', '<Cmd>BufferMovePrevious<CR>', 'Buffer: Move left')
    map('<A-Right>', '<Cmd>BufferMoveNext<CR>', 'Buffer: Move right')

    -- Pin / close / close others
    map('<leader>bp', '<Cmd>BufferPin<CR>', '[B]uffer: [P]in')
    map('<leader>bc', '<Cmd>BufferClose<CR>', '[B]uffer: [C]lose')
    map('<leader>bo', '<Cmd>BufferCloseAllButCurrent<CR>', '[B]uffer: Close [O]thers')

    -- Pick buffer by letter (super handy)
    map('<C-p>', '<Cmd>BufferPick<CR>', 'Buffer: Pick')

    -- Go to buffer 1..9 / last (0)
    for i = 1, 9 do
      map(('<leader>%d'):format(i), ('<Cmd>BufferGoto %d<CR>'):format(i), ('which_key_ignore'):format(i))
    end
    map('<leader>0', '<Cmd>BufferLast<CR>', 'which_key_ignore')

    -- Sort (directory/language)
    map('<leader>bsd', '<Cmd>BufferOrderByDirectory<CR>', '[B]uffer: Sort by [D]irectory')
    map('<leader>bsl', '<Cmd>BufferOrderByLanguage<CR>', '[B]uffer: Sort by [L]anguage')
  end,
}
