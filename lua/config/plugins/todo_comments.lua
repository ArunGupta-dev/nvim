return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    -- Key words highlighted by default:
    -- FIX / FIXME / BUG / FIXIT / ISSUE -> Red
    -- TODO -> Cyan/Blue
    -- WARN / WARNING / XXX -> Yellow
    -- PERF / OPTIM / PERFORMANCE -> Magenta
    -- NOTE / INFO -> Green
    -- HACK / EXTRA -> Orange
  },
  keys = {
    { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
    { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
    { "<leader>ft", "<cmd>TodoTelescope<cr>",                            desc = "Find TODOs in project" },
  },
}
