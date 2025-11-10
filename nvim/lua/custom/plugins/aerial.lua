-- lua/custom/plugins/aerial.lua
-- outline/structure view on <leader>o
return {
  'stevearc/aerial.nvim',
  event = 'LspAttach',
  opts = { backends = { 'treesitter', 'lsp', 'markdown' }, layout = { max_width = { 40, 0.25 } } },
  keys = {
    { '<leader>o', '<cmd>AerialToggle<CR>', desc = '[O]utline' },
  },
}
