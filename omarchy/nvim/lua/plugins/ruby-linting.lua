return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      ruby = { "rubocop" },
    },
    linters = {
      rubocop = {
        cmd = "bundle",
        args = {
          "exec",
          "rubocop",
          "--format",
          "json",
          "--force-exclusion",
          "--stdin",
          function()
            return vim.api.nvim_buf_get_name(0)
          end,
        },
        stdin = true,
        stream = "stdout",
        ignore_exitcode = true,
        parser = require("lint.linters.rubocop").parser,
      },
    },
  },
}
