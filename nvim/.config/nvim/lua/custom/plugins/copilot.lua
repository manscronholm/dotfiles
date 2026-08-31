-- lua/custom/plugins/copilot.lua
return {
  {
    "github/copilot.vim",
    cmd = "Copilot",
    event = "BufWinEnter",
    init = function()
      vim.g.copilot_no_maps = true
      local is_linux = vim.fn.has("linux") == 1
      if not is_linux then
        vim.g.copilot_enterprise_uri = "https://norionbank.ghe.com"
      end
    end,
    config = function()
      -- Block the normal Copilot suggestions
      vim.api.nvim_create_augroup("github_copilot", { clear = true })
      vim.api.nvim_create_autocmd({ "FileType", "BufUnload" }, {
        group = "github_copilot",
        callback = function(args)
          vim.fn["copilot#On" .. args.event]()
        end,
      })
      vim.fn["copilot#OnFileType"]()
    end,
  },
}
