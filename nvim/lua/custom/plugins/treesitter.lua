return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "query",
        "vim",
        "vimdoc",
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = {
            ["]m"] = "@function.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
          },
        },
      },
    },

    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      -- Your custom remaps
      vim.keymap.set("n", "åå", "]m", { remap = true, desc = "Method down" })
      vim.keymap.set("n", "ää", "[m", { remap = true, desc = "Method up" })
    end,
  },
}
