return {

  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim", -- opcional para mais configuração
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("zenbones")
    end,
  },
}
