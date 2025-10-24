-- lua/custom/plugins/copilot.lua
return {
  'github/copilot.vim',
  cmd = 'Copilot',
  event = 'BufWinEnter',
  init = function()
    vim.g.copilot_no_maps = true
  end,
  config = function()
    -- Keep your autocmd behavior that turns off default floating suggestions etc.
    local grp = vim.api.nvim_create_augroup('github_copilot', { clear = true })
    vim.api.nvim_create_autocmd({ 'FileType', 'BufUnload' }, {
      group = grp,
      callback = function(args)
        vim.fn['copilot#On' .. args.event]()
      end,
    })
    vim.fn['copilot#OnFileType']()
  end,
}
