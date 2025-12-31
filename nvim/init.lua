vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

require("config.lazy")

vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, {
  desc = "Find files"
})
