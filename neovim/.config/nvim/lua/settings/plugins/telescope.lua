if Telescope then return end
Telescope = {}

function Telescope.setup()
    local telescope = require('telescope')
    local actions = require('telescope.actions')

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

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

    vim.keymap.set('n', '<leader>gc', builtin.git_commits, {})
    vim.keymap.set('n', '<leader>gs', builtin.git_status, {})
end

return Telescope
