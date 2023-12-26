-- [[ Auto format on save ]]
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local filetype = vim.bo.filetype

    -- List of filetypes for which to use Prettier
    local prettier_filetypes = {
      "javascript",
      "typescript",
      "css",
      "scss",
      "less",
      "html",
      "json",
      "yaml",
      "markdown",
      "typescriptreact",
      "javascriptreact",
      "graphql"
    }

    if vim.tbl_contains(prettier_filetypes, filetype) then
      -- Use Prettier for these filetypes
      local project_prettier = vim.fn.getcwd() .. "/node_modules/.bin/prettier"
      local prettier_executable = vim.fn.executable(project_prettier) == 1 and project_prettier or "prettier"
      local prettier_command = prettier_executable .. " --stdin-filepath " .. vim.fn.shellescape(vim.fn.expand("%"))
      local result = vim.fn.system(prettier_command, vim.api.nvim_buf_get_lines(bufnr, 0, -1, false))
      local success = vim.v.shell_error == 0

      -- Replace buffer content only if Prettier was successful
      if success then
        local cursor_pos = vim.api.nvim_win_get_cursor(0)
        local lines = vim.split(vim.trim(result), "\n")
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
        pcall(vim.api.nvim_win_set_cursor, 0, cursor_pos)
      else
        -- Print error if Prettier was not successful
        print("Prettier formatting failed: " .. vim.fn.trim(result))
      end
    else
      -- Use LSP formatting for other filetypes
      vim.lsp.buf.format({
        bufnr = bufnr,
        timeout_ms = 1000
      })
    end
  end,
})

-- [[ No line number on terminals ]]
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  command = "setlocal nonumber norelativenumber"
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
