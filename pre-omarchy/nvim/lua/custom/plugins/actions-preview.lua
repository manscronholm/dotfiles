-- lua/custom/plugins/actions-preview.lua
-- Niver Code Actions UI
return {
  'aznhe21/actions-preview.nvim',
  opts = {},
  keys = {
    {
      '<leader>rs',
      function()
        require('actions-preview').code_actions()
      end,
      desc = 'Change Signature / Code Actions',
    },
    {
      '<leader>rr',
      function()
        require('actions-preview').code_actions()
      end,
      desc = 'Refactorings (list)',
    },
    {
      '<leader>ga',
      function()
        require('actions-preview').code_actions()
      end,
      mode = { 'n', 'x' },
      desc = '[G]oto [A]ctions',
    },
  },
}
