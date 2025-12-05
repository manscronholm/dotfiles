---- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Exit insert quickly
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- Visual reindent & keep selection
vim.keymap.set("v", "<", "<gv", { desc = "Dedent & reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent & reselect" })

-- Window splits
-- Split, move into it, then pick a buffer
vim.keymap.set("n", "<leader>ws", function()
  vim.cmd("vsplit | wincmd l")
  require("telescope.builtin").buffers({ sort_mru = true, ignore_current_buffer = true })
end, { desc = "Window Split" })

-- LSP conveniences
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>gb", "<C-o>", { desc = "Back in jumplist" })
vim.keymap.set("n", "<leader>gf", "<C-i>", { desc = "Forward in jumplist" })

-- Diagnostic navigation (project-wide)
vim.keymap.set("n", "<leader>en", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>ep", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
