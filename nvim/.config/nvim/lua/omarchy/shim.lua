return {
  {
    "LazyVim/LazyVim",
    lazy = false,
    priority = 1000,
    config = function(_, opts)
      local theme_opts = opts

      -- Fallback to manually require theme.lua if needed (Robustness)
      if not theme_opts or not theme_opts.colorscheme then
        local ok, theme_spec = pcall(require, "omarchy.theme")
        if ok and theme_spec and theme_spec[1] and theme_spec[1].opts then
          theme_opts = theme_spec[1].opts
        end
      end

      -- The core theme application function
      local function apply_theme()
        if not theme_opts or not theme_opts.colorscheme then
          -- If nothing is found, silently exit.
          return
        end

        local cs = theme_opts.colorscheme

        if type(cs) == "function" then
          -- CASE 1: Your custom Omarchy Theme (runs the function)
          cs()
        elseif type(cs) == "string" then
          -- CASE 2: A standard plugin theme (runs the command, e.g., :colorscheme catppuccin)
          -- We must ensure the plugin itself is loaded first.
          if vim.tbl_isempty(vim.api.nvim_get_hl(0, { name = "Normal" })) then
            -- Only attempt to load the plugin if colors aren't already set (prevents flicker)
            require("lazy.core.loader").colorscheme(cs)
          end
          pcall(vim.cmd.colorscheme, cs)
        else
          return -- Unknown format
        end

        vim.cmd("redraw") -- Force redraw after application
      end

      -- Apply immediately, but defer it slightly to run after startup config
      vim.schedule(function()
        apply_theme()
      end)
    end,
  },
}
