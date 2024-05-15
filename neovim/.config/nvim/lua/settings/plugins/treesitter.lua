if TreeSitter then return end
TreeSitter = {}

function TreeSitter.setup()
    require('nvim-treesitter.configs').setup {
        ensure_installed = 'all',
        sync_install = false,
        auto_install = true,
        highlight = {
            enable = true;
            additional_vim_regex_highlighting = false;
        },
        indent = {
            enable = true;
        },
    }

    vim.opt.foldmethod = 'expr'
    vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
end

return TreeSitter
