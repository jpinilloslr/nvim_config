-- Set highlight on search
vim.o.hlsearch = false

-- Line number and relative number
vim.wo.number = true
vim.wo.relativenumber = true

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

-- Set indentation config
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

local langs_indent_config = {
  python = { tabstop = 4, shiftwidth = 4, expandtab = true },
  javascript = { tabstop = 2, shiftwidth = 2, expandtab = true },
  javascriptreact = { tabstop = 2, shiftwidth = 2, expandtab = true },
  typescript = { tabstop = 2, shiftwidth = 2, expandtab = true },
  typescriptreact = { tabstop = 2, shiftwidth = 2, expandtab = true },
  lua = { tabstop = 2, shiftwidth = 2, expandtab = true },
  go = { tabstop = 4, shiftwidth = 4, expandtab = false },
  rust = { tabstop = 4, shiftwidth = 4, expandtab = true },
  c = { tabstop = 4, shiftwidth = 4, expandtab = false },
  cpp = { tabstop = 4, shiftwidth = 4, expandtab = false },
  java = { tabstop = 4, shiftwidth = 4, expandtab = true },
  html = { tabstop = 2, shiftwidth = 2, expandtab = true },
  css = { tabstop = 2, shiftwidth = 2, expandtab = true },
  scss = { tabstop = 2, shiftwidth = 2, expandtab = true },
  sass = { tabstop = 2, shiftwidth = 2, expandtab = true },
  yaml = { tabstop = 2, shiftwidth = 2, expandtab = true },
  json = { tabstop = 2, shiftwidth = 2, expandtab = true },
}

-- Override defaults with specific language settings
for lang, opts in pairs(langs_indent_config) do
  vim.api.nvim_create_autocmd("FileType", {
    pattern = lang,
    callback = function()
      vim.bo.tabstop = opts.tabstop
      vim.bo.shiftwidth = opts.shiftwidth
      vim.opt.expandtab = opts.expandtab
    end,
  })
end
