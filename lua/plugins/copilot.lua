return {
  "github/copilot.vim",
  config = function()
    vim.g.copilot_assume_mapped = true
    vim.api.nvim_set_keymap("i", "<C-S>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    vim.api.nvim_set_keymap('n', '<leader>cc', ':CopilotChat<CR>', { noremap = true, silent = true })
  end,
}
