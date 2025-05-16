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

    -- {
    --   'rebelot/kanagawa.nvim', config = require('settings.plugins.kanagawa').setup
    -- };

    -- { 'navarasu/onedark.nvim',
    --     config = require('settings.plugins.onedark').setup,
    -- };

    { 'stevearc/dressing.nvim', config = true };

    { 'mrjones2014/smart-splits.nvim', config = require('settings.plugins.smart-splits').setup };

    { 'nvim-treesitter/nvim-treesitter', build = ":TSUpdate", config = require('settings.plugins.treesitter').setup };

    { 'amitds1997/remote-nvim.nvim',
        version = "*", -- Pin to GitHub releases
        dependencies = {
            'nvim-lua/plenary.nvim', -- For standard functions
            'MunifTanjim/nui.nvim', -- To build the plugin UI
            'nvim-telescope/telescope.nvim', -- For picking b/w different remote methods
        },
        config = require('settings.plugins.remote-nvim').setup,
    };

    { 'folke/snacks.nvim',
        priority = 1000,
        lazy = false,
        opts = {
            dashboard = { enabled = true },
            bigfile = { enabled = true },
            notifier = { enabled = true },
            explorer = { enabled = true },
            indent = { enabled = true },
        },
        dependencies = {
            'echasnovski/mini.icons',
            'nvim-tree/nvim-web-devicons',
        },
    };

    -- { 'williamboman/mason.nvim', config = true };
    -- 'williamboman/mason-lspconfig.nvim';
    {'neovim/nvim-lspconfig', config = require('settings.plugins.lspconfig').setup };

    -- 'hrsh7th/cmp-nvim-lsp';
    -- 'hrsh7th/cmp-buffer';
    -- 'hrsh7th/cmp-path';
    -- 'hrsh7th/cmp-cmdline';
    -- 'hrsh7th/nvim-cmp';
    -- 'L3MON4D3/LuaSnip';
    -- { 'saadparwaiz1/cmp_luasnip', dependencies = { 'L3MON4D3/LuaSnip', 'hrsh7th/nvim-cmp' },
    -- config = require('settings.plugins.nvim-cmp-luasnip').setup
    -- };
    -- 'hrsh7th/cmp-nvim-lua';

    -- { 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, config = require('settings.plugins.telescope').setup };

    -- { 'folke/neodev.nvim', config = true };
    -- { 'lewis6991/gitsigns.nvim', config = require('settings.plugins.gitsigns').setup };

    -- { 'SmiteshP/nvim-navic', dependencies = { 'neovim/nvim-lspconfig' }, config = true };
    -- { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons', 'SmiteshP/nvim-navic' },
    -- config = require('settings.plugins.lualine').setup
    -- };

    -- { 'ggandor/leap.nvim', dependencies = { 'tpope/vim-repeat' },
    -- config = function()
    -- require('leap').create_default_mappings()
    -- end
    -- };

    { 'echasnovski/mini.files', version = false, config = true,
        keys = {
            { '-', '<cmd>lua MiniFiles.open()<cr>', desc = 'MiniFiles' },
        }
    };

    -- { 'echasnovski/mini.map', version = false,
    --     config = function()
    --         require('mini.map').setup()
    --         MiniMap.open()
    --     end
    -- };

    -- { 'echasnovski/mini.notify', version = false, config = true };
    { 'echasnovski/mini.pick', version = false, config = true, };
})
