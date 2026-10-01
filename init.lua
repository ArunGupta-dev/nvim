require("config.lazy")
require("config.float_terminal")
vim.opt.clipboard = "unnamedplus"
print("Ready for battel....")

-- more options to set to make this good

vim.opt.guicursor = ""

vim.opt.nu = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
vim.opt.colorcolumn = "120"

-- options ends here

-- undo tree stuff
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.local/state/nvim/undodir"
vim.opt.undofile = true

--stuff ends here

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"


vim.diagnostic.config({
  virtual_text = true,     -- Enable inline error messages at the end of lines
  underline = true,        -- Keep red squiggly underlines under errors
  update_in_insert = true, -- Update error messages live while typing in insert mode
})

-- The GOD keymap which make me learn to build neovim from scratch

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)


vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

vim.keymap.set("n", "-", vim.cmd.Ex)

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text.',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
