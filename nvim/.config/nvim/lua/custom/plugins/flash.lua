return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {},
  keys = {
    {
      "<leader>j",
      function()
        require("flash").jump()
      end,
      desc = "[J]ump",
    },
  },
}
