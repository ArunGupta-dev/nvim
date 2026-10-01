-- These are all file type plugins and they are inside after because we want them to load after the vim configs load, so we can override the default option values!

-- Options
-- This is global shift width
vim.opt.shiftwidth = 2
-- This is local shift width and local stands for only this file
vim.opt_local.shiftwidth = 2

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"


vim.diagnostic.config({
  virtual_text = true,     -- Enable inline error messages at the end of lines
  underline = true,        -- Keep red squiggly underlines under errors
  update_in_insert = true, -- Update error messages live while typing in insert mode
})
