vim.opt.termguicolors = true

local nightfox = require('nightfox')

nightfox.setup({
    options = {
        transparent = true,
        terminal_colors = true,
        styles = {
            comments = 'italic',
            keywords = 'bold',
            functions = 'bold,italic',
        },
        inverse = {
            match_paren = true,
            search = true,
            visual = true,
        },
    },
})

vim.cmd "colorscheme nordfox"
