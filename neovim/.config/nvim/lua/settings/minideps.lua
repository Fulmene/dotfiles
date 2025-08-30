-- vi: tabstop=2
-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    'https://github.com/nvim-mini/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup({ path = { package = path_package } })

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local keyopts = { noremap = true, silent = true }

now(function()
  require('mini.icons').setup()

  local hipatterns = require('mini.hipatterns')
  hipatterns.setup({
    highlighters = {
      -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
      fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
      hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
      todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
      note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },

      -- Highlight hex color strings (`#rrggbb`) using that color
      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  })

  local indentscope = require('mini.indentscope')
  indentscope.setup({
    draw = {
      delay = 10,
      animation = indentscope.gen_animation.none()
    },
    symbol = '│',
  })
end)

now(function()
  local tabline = require('mini.tabline')
  local statusline = require('mini.statusline')
  tabline.setup()
  statusline.setup()
end)

add('EdenEast/nightfox.nvim')
now(function()
  require('settings.plugins.nightfox').setup()
end)

add('folke/lazydev.nvim')
later(function()
  if vim.bo.filetype == 'lua' then
    require('lazydev').setup()
  end
end)


add({
  source = 'nvim-treesitter/nvim-treesitter',
  -- Use 'master' while monitoring updates in 'main'
  checkout = 'master',
  monitor = 'main',
  -- Perform action after every checkout
  hooks = { post_checkout = function() vim.cmd('TSUpdate') end },

})
now(function()
  require('settings.plugins.treesitter').setup()
end)

add('neovim/nvim-lspconfig')
now(function()
  require('settings.plugins.lspconfig').setup()
end)

add('mrjones2014/smart-splits.nvim')
later(function()
  require('settings.plugins.smart-splits').setup()
end)

add('rafamadriz/friendly-snippets')

later(function()
  require('mini.files').setup()
  vim.api.nvim_set_keymap('n', '-', '<cmd>lua MiniFiles.open()<cr>', keyopts)

  require('mini.notify').setup()

  require('mini.completion').setup()

  require('mini.pick').setup()

  local map = require('mini.map')
  map.setup({
    integrations = {
      map.gen_integration.builtin_search(),
      map.gen_integration.diff(),
      map.gen_integration.diagnostic(),
    },
    symbols = {
      encode = map.gen_encode_symbols.dot('3x2'),
      scroll_view = ' ',
    },
  })
  MiniMap.open()

  require('mini.cursorword').setup()
  require('mini.trailspace').setup()

  require('mini.git').setup()
  require('mini.diff').setup()

  local gen_loader = require('mini.snippets').gen_loader
  require('mini.snippets').setup({
    snippets = {
      -- Load custom file with global snippets first (adjust for Windows)
      gen_loader.from_file('~/.config/nvim/snippets/global.json'),

      -- Load snippets based on current language by reading files from
      -- "snippets/" subdirectories from 'runtimepath' directories.
      gen_loader.from_lang(),
    },
  })

  require('mini.ai').setup()
  require('mini.pairs').setup()
  require('mini.splitjoin').setup()
  require('mini.surround').setup()

  require('mini.bufremove').setup()
  require('mini.extra').setup()
end)

later(function()
  local map_multistep = require('mini.keymap').map_multistep

  map_multistep('i', '<Tab>',   { 'pmenu_next' })
  map_multistep('i', '<S-Tab>', { 'pmenu_prev' })
  map_multistep('i', '<CR>',    { 'pmenu_accept', 'minipairs_cr' })
  map_multistep('i', '<BS>',    { 'minipairs_bs' })
end)

add('OXY2DEV/markview.nvim')
later(function()
  require('markview').setup({
    preview = {
      icon_provider = 'mini',
    },
  })
end)

add('folke/snacks.nvim')
later(function()
  require('snacks').setup({
    input = { enabled = true },
  })
end)

add('folke/twilight.nvim')
later(function()
  require('twilight').setup({
    dimming = {
      alpha = 0.7,
      color = { "Comment", "#ffffff" },
    },
    context = 20,
  })
  vim.cmd "TwilightEnable"
end)
