return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "lewis6991/async.nvim",
  },
  lazy = false,
  opts = {},
  keys = {
    {
      "<leader>re",
      ":Refactor extract ",
      mode = "x",
      desc = "Refactor: extract (select symbol/name)",
    },
    {
      "<leader>rf",
      ":Refactor extract_to_file ",
      mode = "x",
      desc = "Refactor: extract to file (select path)",
    },
    {
      "<leader>rv",
      ":Refactor extract_var ",
      mode = "x",
      desc = "Refactor: extract variable",
    },

    {
      "<leader>ri",
      ":Refactor inline_var<CR>",
      mode = { "n", "x" },
      desc = "Refactor: inline variable",
    },
    { "<leader>rI", ":Refactor inline_func<CR>", mode = "n", desc = "Refactor: inline function" },

    { "<leader>rb", ":Refactor extract_block<CR>", mode = "n", desc = "Refactor: extract block" },
    {
      "<leader>rbf",
      ":Refactor extract_block_to_file<CR>",
      mode = "n",
      desc = "Refactor: extract block to file",
    },

    {
      "<leader>rr",
      function()
        require("refactoring").select_refactor()
      end,
      mode = { "n", "x" },
      desc = "Refactor: select",
    },
  },
}
