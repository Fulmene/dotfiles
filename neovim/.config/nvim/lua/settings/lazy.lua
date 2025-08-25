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

    {
        'saghen/blink.cmp',
        -- optional: provides snippets for the snippet source
        dependencies = { 'rafamadriz/friendly-snippets' },

        -- use a release tag to download pre-built binaries
        version = '1.*',
        -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
            -- 'super-tab' for mappings similar to vscode (tab to accept)
            -- 'enter' for enter to accept
            -- 'none' for no mappings
            --
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = {
                preset = 'enter',
                ['<Tab>'] = { 'select_next', 'fallback' },
                ['<S-Tab>'] = { 'select_prev', 'fallback' },

                ['<Up>'] = { 'snippet_forward', 'fallback' },
                ['<Down>'] = { 'snippet_backward', 'fallback' },
            },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            -- (Default) Only show the documentation popup when manually triggered
            completion = { documentation = { auto_show = false } },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },

            -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
            -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
            -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
            --
            -- See the fuzzy documentation for more information
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    };

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
