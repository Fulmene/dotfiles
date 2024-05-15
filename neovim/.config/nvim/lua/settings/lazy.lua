local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { 'EdenEast/nightfox.nvim', lazy = false, priority = 1000,
        config = require('settings.plugins.nightfox').setup
    };

    { 'williamboman/mason.nvim', config = true };
    'williamboman/mason-lspconfig.nvim';
    {'neovim/nvim-lspconfig', dependencies = 'williamboman/mason-lspconfig.nvim',
        config = require('settings.plugins.lspconfig').setup
    };

    'hrsh7th/cmp-nvim-lsp';
    'hrsh7th/cmp-buffer';
    'hrsh7th/cmp-path';
    'hrsh7th/cmp-cmdline';
    'hrsh7th/nvim-cmp';
    'L3MON4D3/LuaSnip';
    { 'saadparwaiz1/cmp_luasnip', dependencies = { 'L3MON4D3/LuaSnip', 'hrsh7th/nvim-cmp' },
        config = require('settings.plugins.nvim-cmp-luasnip').setup
    };
    'hrsh7th/cmp-nvim-lua';

    { 'nvim-treesitter/nvim-treesitter', build = ":TSUpdate", config = require('settings.plugins.treesitter').setup };

    { 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, config = require('settings.plugins.telescope').setup };

    'folke/neodev.nvim';
    { 'lewis6991/gitsigns.nvim', config = require('settings.plugins.gitsigns').setup };

    'jamestthompson3/nvim-remote-containers';

    { 'stevearc/dressing.nvim', config = true };
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", config = true };

    { 'SmiteshP/nvim-navic', dependencies = { 'neovim/nvim-lspconfig' }, config = true };
    { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons', 'SmiteshP/nvim-navic' },
        config = require('settings.plugins.lualine').setup
    };

    { 'echasnovski/mini.files', version = false, config = true,
        keys = {
            { '-', '<cmd>lua MiniFiles.open()<cr>', desc = 'MiniFiles' },
        }
    };
    { 'echasnovski/mini.map', version = false,
        config = function()
            require('mini.map').setup()
            MiniMap.open()
        end
    };
})
