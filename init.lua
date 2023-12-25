-- Set <space> as the leader key
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

-- [[ Setting options ]]

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Sync clipboard between OS and Neovim.
vim.o.clipboard = 'unnamedplus'

-- No line wrap
vim.o.wrap = false

-- Save undo history
vim.o.undofile = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Buffer keymaps
vim.keymap.set('n', '<A-a>', ':bprevious<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-d>', ':bnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-q>', ':bdelete<CR>', { noremap = true, silent = true })

-- Terminal keymaps
vim.keymap.set('n', '<leader>tv', ':vsplit | terminal<CR>', { desc = '[T]erminal in [V]ertical Split' })
vim.keymap.set('n', '<leader>th', ':split | terminal<CR>', { desc = '[T]erminal in [H]orizontal Split' })
vim.keymap.set('n', '<leader>t', ':terminal<CR>', { desc = '[T]erminal' })
vim.keymap.set('t', '<C-n>', [[<C-\><C-n>]], { noremap = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

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
