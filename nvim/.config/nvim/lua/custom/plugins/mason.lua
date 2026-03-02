return {
  {
    'williamboman/mason.nvim',
    opts = {
      registries = {
        'github:mason-org/mason-registry',
        'github:Crashdummyy/mason-registry',
      },
    },
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    opts = {
      ensure_installed = {
        -- LSP servers:
        'terraform-ls',
        'azure-pipelines-language-server',
        'bicep-lsp',
        'powershell-editor-services',
        'html-lsp',
        'json-lsp',
        'lemminx',
        'bash-language-server',
        'rust-analyzer',
        -- Formatters/linters:
        'stylua',
        'csharpier',
        'prettier',
        'shfmt',
        'yamlfmt',
      },
      auto_update = false,
      run_on_start = true,
    },
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    opts = {
      ensure_installed = {},
      automatic_installation = false,
    },
  },
}
