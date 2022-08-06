local configs = require 'nvim-treesitter.configs'

configs.setup {
    ensure_installed = 'all',
    highlight = {
        enable = true;
        additional_vim_regex_highlighting = false;
        disable = { "latex" };
    },
    indent = {
        enable = false;
    },
}

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
