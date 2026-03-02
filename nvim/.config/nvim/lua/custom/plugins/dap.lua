-- lua/custom/plugins/dap.lua
-- debugging with UI and F-keys
return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-neotest/nvim-nio',
    },
    config = function()
      local dap, dapui = require 'dap', require 'dapui'
      dapui.setup()
      require('nvim-dap-virtual-text').setup()
      dap.listeners.after.event_initialized['dapui'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui'] = function()
        dapui.close()
      end
      -- Keys
      vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Continue' })
      vim.keymap.set('n', '<F9>', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
      vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Step Over' })
      vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debug: Step Into' })
      vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'Debug: Step Out' })
    end,
  },
  {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'mfussenegger/nvim-dap',
    },
    opts = {
      -- Add more adapters here as needed
      ensure_installed = {
        'netcoredbg', -- C# / .NET
      },
      automatic_installation = true,
      handlers = {
        function(config)
          -- Use Mason's default wiring for adapters we didn't special-case.
          require('mason-nvim-dap').default_setup(config)
        end,
      },
    },
    config = function(_, opts)
      require('mason-nvim-dap').setup(opts)

      -- --- C# (.NET) adapter & a friendly launch config ------------------------
      local dap = require 'dap'

      -- Adapter executable installed by mason at: stdpath('data')/mason/bin/netcoredbg
      local netcoredbg = vim.fn.stdpath 'data' .. '/mason/bin/netcoredbg'
      dap.adapters.coreclr = {
        type = 'executable',
        command = netcoredbg,
        args = { '--interpreter=vscode' },
      }

      -- Try to guess the latest built DLL under bin/Debug; fall back to a prompt.
      local function guess_dll()
        local cwd = vim.fn.getcwd()
        -- Look for the most recent DLL in common Debug folders (netX.Y/ etc.)
        local candidates = vim.fn.globpath(cwd .. '/bin/Debug', '**/*.dll', false, true)
        table.sort(candidates, function(a, b)
          return (vim.loop.fs_stat(a) or { mtime = { nsec = 0 } }).mtime.nsec > (vim.loop.fs_stat(b) or { mtime = { nsec = 0 } }).mtime.nsec
        end)
        return candidates[1]
      end

      dap.configurations.cs = {
        {
          type = 'coreclr',
          name = 'Launch (netcoredbg)',
          request = 'launch',
          program = function()
            local dll = guess_dll()
            if dll and #dll > 0 then
              return dll
            end
            -- Ask once if we can't guess
            return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/', 'file')
          end,
        },
      }

      -- Optional: C# test debugging via neotest + dap
      -- If you installed neotest + neotest-dotnet, you can add a debug binding like:
      -- vim.keymap.set('n', '<leader>tD', function()
      --   require('neotest').run.run({ strategy = 'dap' })
      -- end, { desc = 'Test: debug nearest (DAP)' })
    end,
  },
}
