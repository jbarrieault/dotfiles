return {
  "gbprod/substitute.nvim",
  opts = {},
  keys = {
    { "gr", function() require("substitute").operator() end, desc = "Replace with register" },
    { "grr", function() require("substitute").line() end, desc = "Replace line with register" },
    { "gr", function() require("substitute").visual() end, mode = "x", desc = "Replace with register" },
  },
}
