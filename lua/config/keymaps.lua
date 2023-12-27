-- Keymaps for better default experience
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Buffer
vim.keymap.set('n', '<A-a>', ':bprevious<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-d>', ':bnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-q>', ':bdelete<CR>', { noremap = true, silent = true })

-- Splits
vim.keymap.set('n', '<C-Up>', ':resize +2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', { noremap = true, silent = true })

-- Terminal
vim.keymap.set('n', '<leader>tv', ':vsplit | terminal<CR>', { desc = '[T]erminal in [V]ertical Split' })
vim.keymap.set('n', '<leader>th', ':split | terminal<CR>', { desc = '[T]erminal in [H]orizontal Split' })
vim.keymap.set('n', '<leader>t', ':terminal<CR>', { desc = '[T]erminal' })
vim.keymap.set('t', '<C-n>', [[<C-\><C-n>]], { noremap = true, silent = true })

-- Diagnostic
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
