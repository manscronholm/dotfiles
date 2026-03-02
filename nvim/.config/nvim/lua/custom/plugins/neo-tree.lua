-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  cmd = 'Neotree',
  keys = {
    { '<leader>x', ':Neotree toggle<CR>', desc = '', silent = true },
  },
  opts = {
    window = {
      mappings = {
        ['m'] = {
          'move',
          config = {
            show_path = 'relative', -- "none", "relative", "absolute"
          },
        },
        ['f'] = 'fuzzy_finder', -- make f jump to files
        ['F'] = 'filter_on_submit', -- keep filtering on Shift-F
      },
    },
    filesystem = {
      hijack_netrw_behavior = 'open_current',
      window = {
        mappings = {
          ['<leader>x'] = 'close_window',
        },
      },
    },
  },
}
