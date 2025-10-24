-- lua/custom/plugins/telescope.lua
return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    'nvim-telescope/telescope-ui-select.nvim',
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    local telescope = require 'telescope'
    telescope.setup {
      extensions = { ['ui-select'] = require('telescope.themes').get_dropdown() },
    }
    pcall(telescope.load_extension, 'fzf')
    pcall(telescope.load_extension, 'ui-select')

    local b = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', b.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', b.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', b.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>ss', b.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', b.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', b.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', b.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', b.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', b.oldfiles, { desc = '[S]earch Recent Files (.)' })
    vim.keymap.set('n', '<leader><leader>', b.buffers, { desc = '[ ] Find existing buffers' }) -- keep this behavior
    vim.keymap.set('n', '<leader>/', function()
      b.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { winblend = 10, previewer = false })
    end, { desc = '[/] Fuzzy search in buffer' })
    vim.keymap.set('n', '<leader>s/', function()
      b.live_grep { grep_open_files = true, prompt_title = 'Live Grep in Open Files' }
    end, { desc = '[S]earch [/] in Open Files' })
    vim.keymap.set('n', '<leader>sn', function()
      b.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}
