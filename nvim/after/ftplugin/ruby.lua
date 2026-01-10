-- Auto-format Ruby files on save using SyntaxTree LSP (via Edna)
-- Configuration from: https://github.com/planningcenter/edna/blob/main/docs/editor_integrations.md#neovim

vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function()
    vim.lsp.buf.format()
  end,
  group = vim.api.nvim_create_augroup('AutocmdForRubyFormatting', {}),
})

-- Run RuboCop linting on save and when entering buffer
vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufEnter' }, {
  callback = function()
    require('lint').try_lint()
  end,
  group = vim.api.nvim_create_augroup('RubyLinting', {}),
})
