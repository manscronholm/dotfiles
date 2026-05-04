return {
  "numToStr/Comment.nvim",
  event = "VeryLazy",
  opts = {},
  config = function(_, opts)
    require("Comment").setup(opts)
    vim.keymap.set("n", "<leader>c", function()
      require("Comment.api").toggle.linewise.current()
    end, { desc = "[C]omment line" })
    vim.keymap.set("x", "<leader>c", function()
      require("Comment.api").toggle.linewise(vim.fn.visualmode())
    end, { desc = "[C]omment selection" })
  end,
}
