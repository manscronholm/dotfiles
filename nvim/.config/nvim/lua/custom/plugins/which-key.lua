-- lua/custom/plugins/which-key.lua
return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    -- snappy; increase to ~200 if you ever see flicker
    delay = 0,

    -- a tidier preset (also try "helix")
    preset = 'modern',

    -- float styling
    win = {
      border = 'rounded',
      title_pos = 'center',
      no_overlap = true,
      padding = { 1, 2 }, -- { top/bot, left/right }
      wo = { winblend = 10 }, -- 0=opaque, 100=fully transparent
    },

    -- columns & spacing
    layout = {
      width = { min = 24, max = 36 },
      spacing = 3,
      align = 'left',
    },

    -- tasteful icons only when a Nerd Font is available
    icons = {
      mappings = false,
      group = vim.g.have_nerd_font and ' ' or '+',
      separator = vim.g.have_nerd_font and '' or '→',
      breadcrumb = vim.g.have_nerd_font and '»' or '>',
      keys = vim.g.have_nerd_font and {
        ['<space>'] = '␣',
        ['<cr>'] = '↩',
        ['<tab>'] = '⇥',
      } or {},
    },

    -- hide entries with no description (keeps the menu clean)
    filter = function(mapping)
      return mapping.desc and mapping.desc ~= ''
    end,

    -- optional: slightly smarter ordering
    sort = { 'group', 'alphanum', 'mod' },

    -- your groups (unchanged)
    spec = {
      { '<leader>s', group = '[S]earch' },
      { '<leader>u', group = '[U]nit Test' },
      { '<leader>b', group = '[B]uffer' },
      { '<leader>bs', group = '[B]uffer [S]ort' },
      { '<leader>r', group = '[R]efactoring' },
      { '<leader>w', group = '[W]indow' },
      { '<leader>e', group = '[E]rrors' },
      { '<leader>g', group = '[G]o to' },
      { '<leader>t', group = '[T]erminal' },
      { '<leader>n', group = '[N]oice' },
      { '<leader>§', group = 'Copilot' },
    },
  },

  config = function(_, opts)
    require('which-key').setup(opts)

    -- blend with your colorscheme
    vim.api.nvim_set_hl(0, 'WhichKeyBorder', { link = 'FloatBorder' })
    vim.api.nvim_set_hl(0, 'WhichKeyNormal', { link = 'NormalFloat' })
    vim.api.nvim_set_hl(0, 'WhichKeyTitle', { link = 'FloatTitle' })
  end,
}
