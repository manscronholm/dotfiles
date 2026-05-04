return {
  "numToStr/Comment.nvim",
  event = "VeryLazy",
  opts = {},
  config = function(_, opts)
    local api = require("Comment.api")
    local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)

    require("Comment").setup(opts)

    vim.keymap.set("n", "<leader>c", function()
      api.locked("toggle.linewise.current")()
    end, { desc = "[C]omment line" })

    vim.keymap.set("x", "<leader>c", function()
      vim.api.nvim_feedkeys(esc, "nx", false)
      api.locked("toggle.linewise")(vim.fn.visualmode())
    end, { desc = "[C]omment selection" })
  end,
}
