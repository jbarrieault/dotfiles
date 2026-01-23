return {
  "folke/which-key.nvim",
  init = function()
    -- Create a command :CopyRelativePath (alias :Crp)
    vim.api.nvim_create_user_command("CopyRelativePath", function()
      vim.fn.setreg("+", vim.fn.expand("%:."))
      print("Copied: " .. vim.fn.expand("%:."))
    end, { desc = "Copy relative file path to clipboard" })
    vim.cmd("command! Crp CopyRelativePath")
  end,
  opts = function(_, opts)
    opts.spec = opts.spec or {}
    table.insert(opts.spec, {
      "<leader>fy",
      function()
        vim.fn.setreg("+", vim.fn.expand("%:."))
      end,
      desc = "copy relative file path",
    })
  end,
}
