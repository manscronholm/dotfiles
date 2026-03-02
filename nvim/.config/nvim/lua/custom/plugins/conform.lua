-- lua/custom/plugins/conform.lua
-- Formatting
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      desc = "[F]ormat buffer",
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local disable = { c = true, cpp = true }
      if disable[vim.bo[bufnr].filetype] then
        return nil
      end
      return { timeout_ms = 500, lsp_format = "fallback" }
    end,
    formatters_by_ft = {
      lua = { "stylua" },
      cs = { "csharpier" },
      json = { "prettier" },
      html = { "prettier" },
      xml = { "prettier" },
      terraform = { "terraform_fmt" },
      hcl = { "terraform_fmt" },
      sh = { "shfmt" },
      bash = { "shfmt" },
      rust = { "rustfmt" },
      bicep = { "bicep" },
    },
  },
}
