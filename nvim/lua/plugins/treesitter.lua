return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "go", "lua", "c", "rust" }, -- languages you want
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
}
