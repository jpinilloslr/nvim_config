-- [[ Auto format on save ]]
_G.autoformat_enabled = true

-- Function to toggle autoformatting
function _G.toggle_autoformat()
  _G.autoformat_enabled = not _G.autoformat_enabled
  local status = _G.autoformat_enabled and "enabled" or "disabled"
  vim.notify("Autoformatting is " .. status, vim.log.levels.INFO, { title = "Toggle Autoformat" })
end

vim.api.nvim_set_keymap('n', '<Leader>tf', ':lua toggle_autoformat()<CR>',
  { noremap = true, silent = true, desc = '[T]oogle Auto[f]ormat' })

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function()
    if not _G.autoformat_enabled then
      return
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local filetype = vim.bo.filetype

    -- List of filetypes for which to use Prettier
    local prettier_filetypes = {
      'javascript',
      'typescript',
      'css',
      'scss',
      'less',
      'html',
      'json',
      'yaml',
      'markdown',
      'typescriptreact',
      'javascriptreact',
      'graphql'
    }

    if vim.tbl_contains(prettier_filetypes, filetype) then
      local project_prettier = vim.fn.getcwd() .. '/node_modules/.bin/prettier'
      local prettier_executable = vim.fn.executable(project_prettier) == 1 and project_prettier or 'prettier'
      local prettier_command = prettier_executable .. ' --stdin-filepath ' .. vim.fn.shellescape(vim.fn.expand('%'))
      local result = vim.fn.system(prettier_command, vim.api.nvim_buf_get_lines(bufnr, 0, -1, false))
      local success = vim.v.shell_error == 0

      if success then
        local cursor_pos = vim.api.nvim_win_get_cursor(0)
        local lines = vim.split(vim.trim(result), '\n')
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
        pcall(vim.api.nvim_win_set_cursor, 0, cursor_pos)
      else
        vim.notify(vim.fn.trim(result), vim.log.levels.ERROR, {
          title = 'Prettier formatting error'
        })
      end
    else
      local lsp_attached_and_support_formatting = false
      for _, client in pairs(vim.lsp.get_active_clients()) do
        if client.attached_buffers[bufnr] and client.supports_method("textDocument/formatting") then
          lsp_attached_and_support_formatting = true
          break
        end
      end

      -- For other filetypes, use LSP formatting if available
      if lsp_attached_and_support_formatting then
        vim.lsp.buf.format({
          bufnr = bufnr,
          timeout_ms = 1000
        })
      end
    end
  end,
})

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
