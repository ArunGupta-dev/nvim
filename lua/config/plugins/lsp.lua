return {
  "neovim/nvim-lspconfig",
  dependencies = {
    'saghen/blink.cmp',
    {
      "folke/lazydev.nvim",
      ft = "*",
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup(
      {
        ensure_installed = {
          "lua_ls",
          "pyright",       -- Python LSP
          "gopls",         -- Go LSP
          "clangd",        -- C/C++ LSP
          "rust_analyzer", -- Rust LSP
        },
      }
    )


    local capabilities = require('blink.cmp').get_lsp_capabilities()
    vim.lsp.config("lua_ls", {
      capabilities = capabilities
    })
    vim.lsp.enable("lua_ls")

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
        if not client then return end

        -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
        if client:supports_method('textDocument/completion') then
          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = ev.buf,
            callback = function()
              vim.lsp.buf.format({ bufnr = ev.buf, id = client.id })
            end
          })
        end
      end,
    })
  end,
}
