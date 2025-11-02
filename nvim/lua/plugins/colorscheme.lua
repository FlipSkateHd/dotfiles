return {

  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim", -- opcional para mais configuração
    lazy = false,
    priority = 1000,
    config = function() end,
  },

  {
    "Tsuzat/NeoSolarized.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("NeoSolarized").setup({
        style = "dark", -- Modo dark
        terminal_colors = true, -- Habilita cores pra terminal integrado
        enable_italics = true, -- Itálico para comentários, keywords etc.
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = { bold = true },
          string = { italic = true },
          underline = true,
          undercurl = true,
        },
      })
      vim.cmd.colorscheme("NeoSolarized")

      vim.api.nvim_set_hl(0, "VertSplit", { fg = "#505050" })
    end,
    dependencies = { "tjdevries/colorbuddy.nvim" }, -- Necessário
  },
}
