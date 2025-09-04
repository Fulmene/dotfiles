-- Navigation
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')


-- Buffers
vim.keymap.set('n', '<', ':bprev<CR>')
vim.keymap.set('n', '>', ':bnext<CR>')
vim.keymap.set('n', '<C-q>', ':bwipeout<CR>')


-- Windows
-- Move
vim.keymap.set('n', 'H', '<C-w>h')
vim.keymap.set('n', 'J', '<C-w>j')
vim.keymap.set('n', 'K', '<C-w>k')
vim.keymap.set('n', 'L', '<C-w>l')

vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')


-- Repeat last command
vim.keymap.set('n', '<C-k>', ':<Up><CR>')
