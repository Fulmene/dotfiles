local telescope = require 'telescope'
local actions = require 'telescope.actions'

telescope.setup {
    defaults = {
        mappings = {
            i = {
                ["\\"] = actions.select_vertical;
                ["|"] = actions.select_horizontal;
            },
            n = {
                ["\\"] = actions.select_vertical;
                ["|"] = actions.select_horizontal;
            },
        },
    },
}

vim.api.nvim_set_keymap('n', '<leader>ff', "<Cmd>Telescope find_files<CR>", {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fg', "<Cmd>Telescope live_grep<CR>", {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fb', "<Cmd>Telescope buffers<CR>", {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fh', "<Cmd>Telescope help_tags<CR>", {noremap = true})

vim.api.nvim_set_keymap('n', '<leader>gc', "<Cmd>Telescope git_commits<CR>", {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>gs', "<Cmd>Telescope git_status<CR>", {noremap = true})
