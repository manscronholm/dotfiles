return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
      ensure_installed = {
        "bash",
        "bicep",
        "c",
        "c_sharp",
        "diff",
        "html",
        "json",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "query",
        "terraform",
        "vim",
        "vimdoc",
        "yaml",
      },
      auto_install = true,
    },
    config = function(_, opts)
      require("nvim-treesitter").setup(opts)

      local group = vim.api.nvim_create_augroup("user-treesitter", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = {
          "bash",
          "bicep",
          "c",
          "cs",
          "csharp",
          "diff",
          "html",
          "json",
          "jsonc",
          "lua",
          "markdown",
          "query",
          "terraform",
          "terraform-vars",
          "vim",
          "yaml",
        },
        callback = function(args)
          vim.treesitter.start(args.buf)
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      require("nvim-treesitter-textobjects").setup({
        move = {
          set_jumps = true,
        },
      })

      local move = require("nvim-treesitter-textobjects.move")
      vim.keymap.set({ "n", "x", "o" }, "]m", function()
        move.goto_next_start("@function.outer", "textobjects")
      end, { desc = "Next method start" })
      vim.keymap.set({ "n", "x", "o" }, "[m", function()
        move.goto_previous_start("@function.outer", "textobjects")
      end, { desc = "Previous method start" })

      -- Custom remaps
      vim.keymap.set("n", "åå", "]m", { remap = true, desc = "Method down" })
      vim.keymap.set("n", "ää", "[m", { remap = true, desc = "Method up" })
    end,
  },
}
