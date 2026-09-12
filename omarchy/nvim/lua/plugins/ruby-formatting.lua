return {
  -- Configure LSP for Ruby formatting via syntax_tree
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        syntax_tree = {
          cmd = { "bundle", "exec", "stree", "lsp" },
        },
      },
    },
  },
}
