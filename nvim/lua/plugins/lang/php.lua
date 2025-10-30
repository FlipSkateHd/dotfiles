return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        intelephense = {
          settings = {
            intelephense = {
              diagnostics = {
                missingFileDocblock = false, -- ✅ remove o aviso "Missing file comment"
              },
            },
          },
        },
        phpactor = false, -- ❌ desativa o phpactor
      },
    },
  },
}
