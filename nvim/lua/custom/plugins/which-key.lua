-- lua/custom/plugins/which-key.lua
return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    delay = 0,
    icons = { mappings = vim.g.have_nerd_font, keys = vim.g.have_nerd_font and {} or {} },
    spec = {
      { '<leader>s', group = '[S]earch' },
      { '<leader>u', group = '[U]nit Test' },
      { '<leader>b', group = '[B]uffer' },
      { '<leader>r', group = '[R]efactoring' },
      { '<leader>w', group = '[W]indow' },
      { '<leader>e', group = '[E]rrors' },
      { '<leader>z', group = '[z]Folding' },
      { '<leader>g', group = '[G]o to' },
      { '<leader>t', group = '[T]erminal' },
      { '<leader>n', group = '[N]oice' },
    },
  },
}
