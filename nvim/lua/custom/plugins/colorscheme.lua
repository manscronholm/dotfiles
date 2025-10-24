-- lua/custom/plugins/colorscheme.lua
return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup { flavour = 'mocha', styles = { comments = { 'italic' } } }
    vim.cmd.colorscheme 'catppuccin'
  end,
}
