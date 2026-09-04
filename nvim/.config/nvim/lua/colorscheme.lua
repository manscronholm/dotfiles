local is_linux = vim.fn.has("linux") == 1

if is_linux then
  local theme_file = vim.fn.expand("~/.local/state/omarchy/current/theme/neovim.lua")

  if vim.fn.filereadable(theme_file) == 1 then
    local specs = dofile(theme_file)

    local plugin
    local colorscheme

    for _, spec in ipairs(specs) do
      if spec[1] == "LazyVim/LazyVim" then
        colorscheme = spec.opts and spec.opts.colorscheme
      else
        plugin = spec
      end
    end

    if plugin and colorscheme then
      plugin.config = function()
        vim.cmd.colorscheme(colorscheme)
      end

      return plugin
    end
  end

  return {}
end

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      auto_integrations = true,
      flavour = "mocha",
      dim_inactive = { enabled = true },
      styles = { comments = { "italic" } },
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}
