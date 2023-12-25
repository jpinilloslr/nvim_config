return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    vim.cmd.colorscheme 'tokyonight-storm'
    require('tokyonight').setup({
      style = 'storm',
    })
  end,
}
