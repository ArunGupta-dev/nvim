return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "saghen/blink.cmp",
  },
  config = function()
    -- 1. Initialize Mason
    require("mason").setup()

    -- 2. Tell Mason to ensure these LSPs are installed (it automatically enables them)
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "gopls",
        "pyright",
        "rust_analyzer",
        "clangd",
      },
    })

    -- 3. Set blink.cmp capabilities globally for ALL LSPs using Neovim 0.11's '*' wildcard
    local capabilities = require("blink.cmp").get_lsp_capabilities()
    vim.lsp.config("*", {
      capabilities = capabilities,
    })

    -- 4. Auto-format on save
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
        if not client then return end

        if client:supports_method("textDocument/formatting") then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = ev.buf,
            callback = function()
              vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 500 })
            end,
          })
        end
      end,
    })
  end,
}
