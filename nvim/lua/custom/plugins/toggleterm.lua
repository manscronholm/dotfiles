-- lua/custom/plugins/toggleterm.lua
return {
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = {
    size = function(term)
      if term.direction == 'horizontal' then
        return 12
      end
      if term.direction == 'vertical' then
        return math.floor(vim.o.columns * 0.35)
      end
      return 20
    end,
    shade_terminals = true,
    start_in_insert = true,
    insert_mappings = false, -- we drive with our own leader maps
    persist_size = true,
    direction = 'float',
    float_opts = { border = 'rounded' },
  },
  config = function(_, opts)
    require('toggleterm').setup(opts)

    -- terminal-mode quality of life
    local tn = function(lhs, rhs, desc)
      vim.keymap.set('t', lhs, rhs, { desc = desc, silent = true })
    end
    tn('<Esc>', [[<C-\><C-n>]], 'Terminal: normal-mode') -- make Esc exit to normal mode

    -- Lazygit / REPL “named” terminals
    local Terminal = require('toggleterm.terminal').Terminal
    local lazygit = Terminal:new { cmd = 'lazygit', dir = 'git_dir', direction = 'float', hidden = true }
    local node = Terminal:new { cmd = 'node', hidden = true }
    local python = Terminal:new { cmd = 'python', hidden = true }

    -- Leader keys (avoids neotest's tt/tT/ts/to to prevent conflict)
    vim.keymap.set('n', '<leader>tf', '<cmd>ToggleTerm direction=float<CR>', { desc = '[T]erminal (float)' })
    vim.keymap.set('n', '<leader>th', '<cmd>ToggleTerm direction=horizontal<CR>', { desc = '[T]erminal (horizontal)' })
    vim.keymap.set('n', '<leader>tv', '<cmd>ToggleTerm direction=vertical<CR>', { desc = '[T]erminal (vertical)' })

    vim.keymap.set('n', '<leader>tg', function()
      lazygit:toggle()
    end, { desc = '[T]erminal: lazy[g]it' })
    vim.keymap.set('n', '<leader>tn', function()
      node:toggle()
    end, { desc = '[T]erminal: [n]ode REPL' })
    vim.keymap.set('n', '<leader>tp', function()
      python:toggle()
    end, { desc = '[T]erminal: [p]ython REPL' })

    -- Optional: toggle last terminal from terminal-mode too
    vim.keymap.set('t', '<leader>tf', '<cmd>ToggleTerm direction=float<CR>', { desc = '[T]erminal (float)' })
    vim.keymap.set('t', '<leader>th', '<cmd>ToggleTerm direction=horizontal<CR>', { desc = '[T]erminal (horizontal)' })
    vim.keymap.set('t', '<leader>tv', '<cmd>ToggleTerm direction=vertical<CR>', { desc = '[T]erminal (vertical)' })
  end,
}
