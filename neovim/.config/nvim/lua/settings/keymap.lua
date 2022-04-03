vim.g.mapleader = ' '

-- Navigation
vim.api.nvim_set_keymap('n', 'j', 'gj', {noremap = true})
vim.api.nvim_set_keymap('n', 'k', 'gk', {noremap = true})


-- Windows
-- Move
vim.api.nvim_set_keymap('n', 'H', '<C-w>h', {noremap = true})
vim.api.nvim_set_keymap('n', 'J', '<C-w>j', {noremap = true})
vim.api.nvim_set_keymap('n', 'K', '<C-w>k', {noremap = true})
vim.api.nvim_set_keymap('n', 'L', '<C-w>l', {noremap = true})

-- Maximise
vim.api.nvim_set_keymap('n', '<leader>_', '<C-w>_', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>|', '<C-w>|', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>=', '<C-w>_<C-w>|', {noremap = true})


-- Tabs
vim.api.nvim_set_keymap('n', '<C-j>', ':tabprevious<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-k>', ':tabnext<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>q', ':tabclose<CR>', {noremap = true})


-- Repeat last command
vim.api.nvim_set_keymap('n', '<leader>k', ':<Up><CR>', {noremap = true})


-- Diagnostics
vim.api.nvim_set_keymap('n', '<leader>fd', ':lua vim.diagnostic.open_float()<CR>', {noremap = true})


-- LSP
vim.api.nvim_set_keymap('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>', {noremap = true})
