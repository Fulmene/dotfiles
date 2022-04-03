local install_path = vim.fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
end

require 'paq' {
    'savq/paq-nvim';

    {'kyazdani42/nvim-web-devicons', opts = true};
    'nvim-lua/plenary.nvim';

    'shaunsingh/nord.nvim';
    'EdenEast/nightfox.nvim';
    'rmehri01/onenord.nvim';

    'nvim-lualine/lualine.nvim';

    'neovim/nvim-lspconfig';
    'hrsh7th/cmp-nvim-lsp';
    'hrsh7th/cmp-buffer';
    'hrsh7th/cmp-path';
    'hrsh7th/cmp-cmdline';
    'hrsh7th/nvim-cmp';
    'hrsh7th/cmp-nvim-lua';

    'L3MON4D3/LuaSnip';
    'saadparwaiz1/cmp_luasnip';

    'rafamadriz/friendly-snippets';

    'nvim-telescope/telescope.nvim';

    'tpope/vim-repeat';

    {'nvim-treesitter/nvim-treesitter', run = ":TSUpdate"};

    -- 'wfxr/minimap.vim';

    'ggandor/lightspeed.nvim';

    'lewis6991/gitsigns.nvim';

    'kyazdani42/nvim-tree.lua';

    'fladson/vim-kitty';
    'dylon/vim-antlr';
}
