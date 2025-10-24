-- lua/keymaps.lua
---- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Exit insert quickly
vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Exit insert mode' })

-- Keep your <C-h/j/k/l> for windows; add Alt-hjkl to mirror IdeaVim habit
vim.keymap.set('n', '<A-h>', '<C-w>h', { desc = 'Move to window left' })
vim.keymap.set('n', '<A-j>', '<C-w>j', { desc = 'Move to window below' })
vim.keymap.set('n', '<A-k>', '<C-w>k', { desc = 'Move to window above' })
vim.keymap.set('n', '<A-l>', '<C-w>l', { desc = 'Move to window right' })

-- Tabs like IDE: Alt-n / Alt-p
vim.keymap.set('n', '<A-n>', '<cmd>tabnext<CR>', { desc = 'Next tab' })
vim.keymap.set('n', '<A-p>', '<cmd>tabprevious<CR>', { desc = 'Previous tab' })

-- Visual reindent & keep selection
vim.keymap.set('v', '<', '<gv', { desc = 'Dedent & reselect' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent & reselect' })

-- Folds
vim.keymap.set('n', '<leader>zc', 'zM', { desc = 'Fold all regions' })
vim.keymap.set('n', '<leader>zo', 'zR', { desc = 'Unfold all regions' })

-- Window splits
vim.keymap.set('n', '<leader>wv', '<cmd>vsplit<CR>', { desc = 'Split vertically' })
vim.keymap.set('n', '<leader>wh', '<cmd>split<CR>', { desc = 'Split horizontally' })
vim.keymap.set('n', '<leader>wu', '<cmd>close<CR>', { desc = 'Close current split' })

-- Keep diagnostics on <leader>q; use <leader>bd to "close content" (buffer) instead
vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<CR>', { desc = 'Close buffer' })

-- LSP conveniences
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
vim.keymap.set('n', '<leader>gb', '<C-o>', { desc = 'Back in jumplist' })
vim.keymap.set('n', '<leader>gf', '<C-i>', { desc = 'Forward in jumplist' })

-- Diagnostic navigation (project-wide)
vim.keymap.set('n', '<leader>en', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
vim.keymap.set('n', '<leader>ep', vim.diagnostic.goto_prev, { desc = 'Prev diagnostic' })

-- Scratch buffer
vim.keymap.set('n', '<leader>fs', function()
  vim.cmd.enew()
  vim.bo.buftype = 'nofile'
  vim.bo.bufhidden = 'hide'
  vim.bo.swapfile = false
end, { desc = 'New scratch buffer' })

-- Classic quality-of-life
vim.keymap.set('n', 'Q', 'gq', { desc = 'Format with gq (disable Ex)' })
vim.keymap.set('n', 'qj', '@q', { desc = 'Run macro in register q' })
