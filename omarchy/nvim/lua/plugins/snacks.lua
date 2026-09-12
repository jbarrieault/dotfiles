return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          -- show hidden files
          hidden = true,
          -- show gitignored files
          ignored = true,
          -- hide specific directories
          exclude = {},
        },
        files = {
          -- show hidden files
          hidden = true,
          -- hide gitignored files
          ignored = false,
          -- hide specific directories
          exclude = { ".devbox", "node_modules" },
        },
      },
    },
  },
}
