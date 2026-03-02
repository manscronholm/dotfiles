-- Configure underline styles for diagnostics
local function uc(group, sp)
  vim.api.nvim_set_hl(0, group, { undercurl = true, sp = sp })
end
uc("DiagnosticUnderlineError", "#ff6b6b")
uc("DiagnosticUnderlineWarn", "#e0af68")
uc("DiagnosticUnderlineInfo", "#5bc0eb")
uc("DiagnosticUnderlineHint", "#8bd5ca")

-- Highlight yanked (copied) text for a brief moment
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
