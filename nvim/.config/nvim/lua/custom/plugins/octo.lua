return {
  "pwntester/octo.nvim",
  cmd = "Octo",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    picker = "telescope",
    enable_builtin = true,
    mappings = {
      review_diff = {
        select_prev_entry = { lhs = "åå" },
        select_next_entry = { lhs = "ää" },
      },
      review_thread = {
        select_prev_entry = { lhs = "åå" },
        select_next_entry = { lhs = "ää" },
      },
      file_panel = {
        select_prev_entry = { lhs = "åå" },
        select_next_entry = { lhs = "ää" },
      },
    },
  },
  init = function()
    local function enable_folds()
      if vim.w.octo_fold_restore == nil then
        vim.w.octo_fold_restore = vim.wo.foldenable
      end
      vim.wo.foldenable = true
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "octo",
      callback = function(event)
        enable_folds()
        vim.keymap.set("n", "<leader>of", "za", { buffer = event.buf, desc = "Toggle Octo fold" })
      end,
    })
    vim.api.nvim_create_autocmd("BufEnter", {
      callback = function(event)
        if vim.bo[event.buf].filetype == "octo" then
          enable_folds()
        end
      end,
    })
    vim.api.nvim_create_autocmd("BufLeave", {
      callback = function(event)
        if vim.bo[event.buf].filetype == "octo" and vim.w.octo_fold_restore ~= nil then
          vim.wo.foldenable = vim.w.octo_fold_restore
          vim.w.octo_fold_restore = nil
        end
      end,
    })
  end,
  keys = {
    {
      "<leader>op",
      "<cmd>Octo search is:pr is:open involves:@me sort:updated-desc<cr>",
      desc = "Open pull requests involving me (all repos)",
    },
    {
      "<leader>ov",
      "<cmd>Octo search is:pr is:open review-involves:@me sort:updated-desc<cr>",
      desc = "Open pull requests for my reviews (all repos)",
    },
    { "<leader>oa", "<cmd>Octo actions<cr>", desc = "Browse Octo actions" },
    { "<leader>oc", "<cmd>Octo pr create<cr>", desc = "Create pull request" },
    { "<leader>od", "<cmd>Octo pr diff<cr>", desc = "Show pull request diff" },
    { "<leader>oh", "<cmd>Octo pr changes<cr>", desc = "Browse changed files" },
    { "<leader>or", "<cmd>Octo review<cr>", desc = "Start or resume pull request review" },
    { "<leader>om", "<cmd>Octo review comments<cr>", desc = "List pending review comments" },
    { "<leader>os", "<cmd>Octo review submit<cr>", desc = "Submit pull request review" },
    { "<leader>oq", "<cmd>Octo review close<cr>", desc = "Close review view" },
  },
}
