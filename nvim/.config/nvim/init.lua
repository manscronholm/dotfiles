-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Platform detection: load Omarchy theme system on Linux, standalone Catppuccin on macOS
local is_linux = vim.fn.has("linux") == 1

if is_linux then
  require("omarchy")
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out =
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "tpope/vim-sleuth",
  { import = "custom.plugins" },
  { import = "colorscheme", cond = not is_linux },
  { import = "omarchy.theme", cond = is_linux },
  { import = "omarchy.shim", cond = is_linux },
  { import = "omarchy.omarchy-theme-hotreload", cond = is_linux },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})
-- vim: ts=2 sts=2 sw=2 et
