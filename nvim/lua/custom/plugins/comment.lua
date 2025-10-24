-- lua/custom/plugins/comment.lua
-- toggle comments on <leader>c
return {
  'numToStr/Comment.nvim',
  event = 'VeryLazy',
  config = function()
    require('Comment').setup()
    vim.keymap.set('n', '<leader>c', function()
      require('Comment.api').toggle.linewise.current()
    end, { desc = 'Comment line' })
    vim.keymap.set('x', '<leader>c', function()
      require('Comment.api').toggle.linewise(vim.fn.visualmode())
    end, { desc = 'Comment selection' })
  end,
}
