local ruby_lsp_path = "C:/Users/Oskar/AppData/Local/Microsoft/WindowsApps/ruby-lsp"
return {
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "tsserver", "ruby_lsp" },
      })
    end,
  },
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")
    lspconfig.tsserver.setup({})
    lspconfig.ruby_lsp.setup({
      mason = false,
      cmd = { ruby_lsp_path },
    })

    vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
    vim.keymap.set({ "n" }, "<leader>ca", vim.lsp.buf.code_action, {})
  end,
}
