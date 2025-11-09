-- lua/custom/plugins/colorscheme.lua
return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      auto_integrations = true,
      flavour = 'mocha',
      dim_inactive = { enabled = true },
      styles = { comments = { 'italic' } },
    }
    vim.cmd.colorscheme 'catppuccin'
  end,
}
