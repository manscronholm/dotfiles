-- lua/custom/plugins/trouble.lua
-- “Problems” panel on <leader>xx
return {
  'folke/trouble.nvim',
  cmd = { 'Trouble' },
  opts = {},
  keys = {
    { '<leader>qx', '<cmd>Trouble diagnostics toggle<CR>', desc = 'Diagnostics (Trouble)' },
  },
}
