vim.g.minimap_auto_start = 1
vim.g.minimap_highlight_range = 1
vim.g.minimap_git_colors = 1

vim.api.nvim_set_keymap('n', '<leader>mm', "<Cmd>MinimapToggle<CR>", {noremap = true})
