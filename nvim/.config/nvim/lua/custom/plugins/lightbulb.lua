return {
  {
    'kosayoda/nvim-lightbulb',
    event = 'LspAttach',
    opts = {
      autocmd = { enabled = true },
      sign = { enabled = true, priority = 20 },
      virtual_text = { enabled = false }, -- keep things clean
      float = { enabled = false },
      status_text = { enabled = false },
    },
  },
}
