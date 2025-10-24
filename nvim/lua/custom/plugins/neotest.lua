-- lua/custom/plugins/neotest.lua
-- run tests & show summary
return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'Issafalcon/neotest-dotnet', -- add more adapters if you use other stacks
  },
  opts = function()
    return {
      adapters = {
        require 'neotest-dotnet' { discovery_root = 'solution' },
      },
    }
  end,
  keys = {
    {
      '<leader>ut',
      function()
        require('neotest').run.run()
      end,
      desc = 'Test: Run nearest',
    },
    {
      '<leader>uT',
      function()
        require('neotest').run.run(vim.fn.expand '%')
      end,
      desc = 'Test: Run file',
    },
    {
      '<leader>us',
      function()
        require('neotest').summary.toggle()
      end,
      desc = 'Test: Summary',
    },
    {
      '<leader>uo',
      function()
        require('neotest').output.open { enter = true }
      end,
      desc = 'Test: Output',
    },
  },
}
