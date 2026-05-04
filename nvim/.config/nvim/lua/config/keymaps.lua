vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })

vim.keymap.set("v", "<", "<gv", { desc = "Dedent & reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent & reselect" })

vim.keymap.set("n", "<leader>ws", function()
  vim.cmd("vsplit | wincmd l")
  require("telescope.builtin").buffers({ sort_mru = true, ignore_current_buffer = true })
end, { desc = "Window Split" })

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>gb", "<C-o>", { desc = "Back in jumplist" })
vim.keymap.set("n", "<leader>gf", "<C-i>", { desc = "Forward in jumplist" })

vim.keymap.set("n", "<leader>en", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>ep", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
