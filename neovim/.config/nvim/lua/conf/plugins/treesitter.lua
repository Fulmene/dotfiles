if TreeSitter then return end
TreeSitter = {}

function TreeSitter.setup()
    require('nvim-treesitter.configs').setup {
        sync_install = false,
        auto_install = true,
        folds = {
            enable = true;
        },
        highlight = {
            enable = true;
            additional_vim_regex_highlighting = false;
        },
        indent = {
            enable = true;
        },
    }

    vim.opt.foldmethod = 'expr'
    vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.opt.foldtext = ""
    vim.opt.foldlevel = 3
end

return TreeSitter
