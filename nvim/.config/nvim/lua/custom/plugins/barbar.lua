return {
  "romgrk/barbar.nvim",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    animation = true,
    insert_at_end = true,
    maximum_padding = 2,
    icons = {
      buffer_index = true,
      buffer_number = false,
      button = "✕",
      inactive = { separator = { left = " ", right = " " } },
    },
    sidebar_filetypes = {
      ["neo-tree"] = true,
      aerial = { event = "BufWinLeave" },
    },
  },
  config = function(_, opts)
    require("barbar").setup(opts)

    local map = function(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { desc = desc, silent = true })
    end

    map("<A-,>", "<Cmd>BufferPrevious<CR>", "Buffer: Previous")
    map("<A-.>", "<Cmd>BufferNext<CR>", "Buffer: Next")
    map("<A-h>", "<Cmd>BufferMovePrevious<CR>", "Buffer: Move left")
    map("<A-l>", "<Cmd>BufferMoveNext<CR>", "Buffer: Move right")
    map("<leader>bp", "<Cmd>BufferPin<CR>", "[B]uffer: [P]in")
    map("<leader>q", "<Cmd>BufferClose<CR>", "")
    map("<leader>bo", "<Cmd>BufferCloseAllButCurrent<CR>", "[B]uffer: Close [O]thers")
    map("<C-p>", "<Cmd>BufferPick<CR>", "Buffer: Pick")

    for i = 1, 9 do
      map(("<leader>%d"):format(i), ("<Cmd>BufferGoto %d<CR>"):format(i), "which_key_ignore")
    end
    map("<leader>0", "<Cmd>BufferLast<CR>", "which_key_ignore")
    map("<leader>bsd", "<Cmd>BufferOrderByDirectory<CR>", "[B]uffer: Sort by [D]irectory")
    map("<leader>bsl", "<Cmd>BufferOrderByLanguage<CR>", "[B]uffer: Sort by [L]anguage")
  end,
}
