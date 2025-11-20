-- lua/custom/plugins/copilot.lua
return {
  {
    'github/copilot.vim',
    cmd = 'Copilot',
    event = 'BufWinEnter',
    init = function()
      vim.g.copilot_no_maps = true
    end,
    config = function()
      -- Block the normal Copilot suggestions
      vim.api.nvim_create_augroup('github_copilot', { clear = true })
      vim.api.nvim_create_autocmd({ 'FileType', 'BufUnload' }, {
        group = 'github_copilot',
        callback = function(args)
          vim.fn['copilot#On' .. args.event]()
        end,
      })
      vim.fn['copilot#OnFileType']()
    end,
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim', branch = 'master' },
    },
    opts = {
      model = 'gpt-4.1',
      temperature = 0.1, -- Lower = focused, higher = creative
      window = {
        layout = 'vertical', -- 'vertical', 'horizontal', 'float'
        width = 0.25, -- 25% of screen width
      },
      headers = {
        user = '👤 You',
        assistant = '🤖 Copilot',
        tool = '🔧 Tool',
      },
      separator = '━━',
      auto_fold = true,
      auto_insert_mode = true,
    },
    keys = {
      { '<leader>§c', '<cmd>CopilotChatToggle<cr>', desc = 'CopilotChat: Toggle' },
      { '<leader>§o', '<cmd>CopilotChatOpen<cr>', desc = 'CopilotChat: Open' },
      { '<leader>§C', '<cmd>CopilotChatClose<cr>', desc = 'CopilotChat: Close' },
      { '<leader>§r', '<cmd>CopilotChatReset<cr>', desc = 'CopilotChat: Reset' },
      { '<leader>§m', '<cmd>CopilotChatModels<cr>', desc = 'CopilotChat: Choose Model' },
      { '<leader>§p', '<cmd>CopilotChatPrompts<cr>', desc = 'CopilotChat: Prompt Picker' },
    },
    config = function(_, opts)
      local chat = require 'CopilotChat'
      chat.setup(opts)

      -- buffer-local tweaks for the chat window
      local aug = vim.api.nvim_create_augroup('CopilotChatLocalOpts', { clear = true })
      vim.api.nvim_create_autocmd('FileType', {
        group = aug,
        pattern = 'copilot-chat',
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
          vim.opt_local.conceallevel = 0
        end,
      })
    end,
  },
}
