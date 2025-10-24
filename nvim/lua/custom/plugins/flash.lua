-- lua/custom/plugins/flash.lua
-- EasyMotions-style jump on <leader>j
return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {},
  keys = {
    {
      '<leader>j',
      function()
        require('flash').jump()
      end,
      desc = 'Jump (Flash/EasyMotion-like)',
    },
  },
}
