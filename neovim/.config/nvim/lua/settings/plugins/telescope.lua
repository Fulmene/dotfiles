local telescope = require 'telescope'
local actions = require 'telescope.actions'

telescope.setup {
    defaults = {
        mappings = {
            i = {
                ["<C-o>"] = actions.select_default;
                ["<CR>"] = actions.select_vertical;
                ["|"] = actions.select_horizontal;
            },
            n = {
                ["<C-o>"] = actions.select_default;
                ["<CR>"] = actions.select_vertical;
                ["|"] = actions.select_horizontal;
            },
        },
    },
}

vim.api.nvim_set_keymap('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<cr>", {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<cr>", {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<cr>", {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fh', "<cmd>lua require('telescope.builtin').help_tags()<cr>", {noremap = true})
