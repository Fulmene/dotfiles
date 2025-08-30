if OneDark then return end
OneDark = {}

function OneDark.setup()
    require('onedark').setup({
        code_style = {
            comments = 'italic',
            keywords = 'bold',
            functions = 'bold,italic',
            conditonals = 'italic',
        },
        highlights = {
            SnacksIndentScope = { fg = "$blue" },
        },
    })

    vim.cmd "colorscheme onedark"
end

return OneDark
