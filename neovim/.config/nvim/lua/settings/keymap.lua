vim.g.mapleader = ' '

local opts = { noremap = true, silent = true }

-- Navigation
vim.api.nvim_set_keymap('n', 'j', 'gj', opts)
vim.api.nvim_set_keymap('n', 'k', 'gk', opts)


-- Buffers
vim.api.nvim_set_keymap('n', '<', ':bprev<CR>', opts)
vim.api.nvim_set_keymap('n', '>', ':bnext<CR>', opts)
vim.api.nvim_set_keymap('n', '<C-q>', ':bwipeout<CR>', opts)


-- Windows
-- Move
vim.api.nvim_set_keymap('n', 'H', '<C-w>h', opts)
vim.api.nvim_set_keymap('n', 'J', '<C-w>j', opts)
vim.api.nvim_set_keymap('n', 'K', '<C-w>k', opts)
vim.api.nvim_set_keymap('n', 'L', '<C-w>l', opts)


-- Repeat last command
vim.api.nvim_set_keymap('n', '<C-k>', ':<Up><CR>', opts)
