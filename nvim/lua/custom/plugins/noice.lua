return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
  opts = {
    -- Floating ":" cmdline (includes :lua, /, ?)
    cmdline = {
      enabled = true,
      view = 'cmdline_popup',
      format = {
        cmdline = { pattern = '^:', icon = '', lang = 'vim' },
        search_down = { kind = 'search', pattern = '^/', icon = ' /', lang = 'regex' },
        search_up = { kind = 'search', pattern = '^%?', icon = ' ?', lang = 'regex' },
        filter = { pattern = '^:%s*!', icon = '', lang = 'bash' },
        lua = { pattern = '^:%s*lua%s+', icon = '', lang = 'lua' },
        help = { pattern = '^:%s*he?l?p?%s+', icon = '󰙎' },
      },
    },
    -- Use notify for messages; keep a search count overlay quiet
    messages = { enabled = true, view = 'notify', view_search = 'virtualtext' },
    routes = {
      { filter = { event = 'msg_show', kind = 'search_count' }, opts = { skip = true } },
      { filter = { event = 'msg_show', find = 'written' }, opts = { skip = true } },
    },
    -- Nice popupmenu backend
    popupmenu = { enabled = true, backend = 'nui' },
    -- LSP polish (hover/signature in pretty popups)
    lsp = {
      progress = { enabled = false }, -- Temp fix cause roslyn is actin up
      signature = { enabled = true, auto_open = { enabled = true, trigger = true } },
      hover = { enabled = true },
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
      },
    },
    presets = {
      bottom_search = false, -- keep the search prompt in the popup too
      command_palette = true, -- nicer cmdline layout
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = true,
    },
    views = {
      cmdline_popup = {
        position = { row = '30%', col = '50%' },
        size = { width = 60, height = 'auto' },
        border = { style = 'rounded' },
        win_options = { winhighlight = { Normal = 'Normal', FloatBorder = 'FloatBorder' } },
      },
      popupmenu = {
        relative = 'editor',
        position = { row = '35%', col = '50%' },
        size = { width = 60, height = 10 },
        border = { style = 'rounded' },
        win_options = { winhighlight = { Normal = 'Normal', FloatBorder = 'FloatBorder' } },
      },
    },
  },
  config = function(_, opts)
    require('noice').setup(opts)
    -- route vim.notify through nvim-notify
    vim.notify = require 'notify'

    -- Quick Lua prompt (shows in Noice’s popup)
    vim.keymap.set('n', '<leader>L', function()
      vim.api.nvim_feedkeys(':lua ', 'n', false)
    end, { desc = 'Lua: command-line prompt' })

    -- Noice helpers
    vim.keymap.set('n', '<leader>nl', '<Cmd>Noice last<CR>', { desc = '[N]oice: [l]ast message' })
    vim.keymap.set('n', '<leader>nh', '<Cmd>Noice history<CR>', { desc = '[N]oice: [h]istory' })
    vim.keymap.set('n', '<leader>nd', '<Cmd>Noice dismiss<CR>', { desc = '[N]oice: [d]ismiss' })
  end,
}
