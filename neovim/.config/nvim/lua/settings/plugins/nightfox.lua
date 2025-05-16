if NightFox then return end
NightFox = {}

function NightFox.setup()
    vim.opt.termguicolors = true

    require('nightfox').setup({
        options = {
            transparent = false,
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
end

return NightFox
