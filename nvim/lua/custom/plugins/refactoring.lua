-- lua/custom/plugins/refactoring.lua
-- Refactorings
return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter' },
  opts = {},
  keys = {
    {
      '<leader>rm',
      function()
        require('refactoring').refactor 'Extract Function'
      end,
      mode = { 'n', 'x' },
      desc = 'Extract Method',
    },
    {
      '<leader>rv',
      function()
        require('refactoring').refactor 'Extract Variable'
      end,
      mode = { 'n', 'x' },
      desc = 'Introduce Variable',
    },
  },
}
