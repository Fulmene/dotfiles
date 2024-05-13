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
    'shaunsingh/nord.nvim';
    'EdenEast/nightfox.nvim';

    'williamboman/mason.nvim';
    'williamboman/mason-lspconfig.nvim';
    'neovim/nvim-lspconfig';

    'hrsh7th/cmp-nvim-lsp';
    'hrsh7th/cmp-buffer';
    'hrsh7th/cmp-path';
    'hrsh7th/cmp-cmdline';
    'hrsh7th/nvim-cmp';
    'L3MON4D3/LuaSnip';
    'saadparwaiz1/cmp_luasnip';
    'hrsh7th/cmp-nvim-lua';

    { 'nvim-treesitter/nvim-treesitter', build = ":TSUpdate" };

    { 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' } };

    'folke/neodev.nvim';
    'lewis6991/gitsigns.nvim';

    'stevearc/dressing.nvim';
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} };

    { 'SmiteshP/nvim-navic', dependencies = { 'neovim/nvim-lspconfig' } };
    { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } };
})
