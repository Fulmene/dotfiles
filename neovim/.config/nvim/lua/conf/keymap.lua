local keyopts = { noremap = true, silent = true }

-- Navigation
vim.api.nvim_set_keymap('n', 'j', 'gj', keyopts)
vim.api.nvim_set_keymap('n', 'k', 'gk', keyopts)


-- Buffers
vim.api.nvim_set_keymap('n', '<', ':bprev<CR>', keyopts)
vim.api.nvim_set_keymap('n', '>', ':bnext<CR>', keyopts)
vim.api.nvim_set_keymap('n', '<C-q>', ':bwipeout<CR>', keyopts)


-- Windows
-- Move
vim.api.nvim_set_keymap('n', 'H', '<C-w>h', keyopts)
vim.api.nvim_set_keymap('n', 'J', '<C-w>j', keyopts)
vim.api.nvim_set_keymap('n', 'K', '<C-w>k', keyopts)
vim.api.nvim_set_keymap('n', 'L', '<C-w>l', keyopts)


-- Repeat last command
vim.api.nvim_set_keymap('n', '<C-k>', ':<Up><CR>', keyopts)
