-- lua/custom/plugins/mini.lua
return {
  'echasnovski/mini.nvim',
  config = function()
    require('mini.ai').setup { n_lines = 500 }
    require('mini.surround').setup()

    local statusline = require 'mini.statusline'
    statusline.setup { use_icons = vim.g.have_nerd_font }

    -- Keep your compact cursor location
    statusline.section_location = function()
      return '%2l:%-2v'
    end

    -- Prepend a tiny buffer badge to the filename section
    local old_filename = statusline.section_filename
    statusline.section_filename = function(...)
      local base = old_filename(...)
      local bufnr = vim.fn.bufnr '%'
      -- Shows e.g. “[B12] init.lua”
      return string.format('[B%s] %s', bufnr, base)
    end
  end,
}
