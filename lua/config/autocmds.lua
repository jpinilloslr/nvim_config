-- [[ Auto format on save ]]
_G.autoformat_enabled = true

function _G.toggle_autoformat()
  _G.autoformat_enabled = not _G.autoformat_enabled
  local status = _G.autoformat_enabled and "enabled" or "disabled"
  vim.notify("Autoformatting is " .. status, vim.log.levels.INFO, { title = "Toggle Autoformat" })
end

vim.api.nvim_set_keymap('n', '<Leader>tf', ':lua toggle_autoformat()<CR>',
  { noremap = true, silent = true, desc = '[T]oogle Auto[f]ormat' })

vim.cmd([[
  autocmd BufWritePre *.py if luaeval('_G.autoformat_enabled') | Neoformat | endif
  autocmd BufWritePre *.js,*.ts,*.jsx,*.tsx if luaeval('_G.autoformat_enabled') | Neoformat | endif
  autocmd BufWritePre *.css,*.scss if luaeval('_G.autoformat_enabled') | Neoformat | endif
  autocmd BufWritePre *.html,*.htm if luaeval('_G.autoformat_enabled') | Neoformat | endif
  autocmd BufWritePre *.json if luaeval('_G.autoformat_enabled') | Neoformat | endif
  autocmd BufWritePre *.yml,*.yaml if luaeval('_G.autoformat_enabled') | Neoformat | endif
  autocmd BufWritePre *.graphql,*.gql if luaeval('_G.autoformat_enabled') | Neoformat | endif
]])

-- [[ No line number on terminals ]]
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  command = 'setlocal nonumber norelativenumber'
})

-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
