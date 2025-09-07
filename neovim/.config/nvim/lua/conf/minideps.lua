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

add('lukas-reineke/indent-blankline.nvim')

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
      animation = indentscope.gen_animation.none(),
    },
    options = {
      try_as_border = true,
    },
    symbol = '│',
  })

  require('ibl').setup({
    indent = { char = '│' },
  })
end)

add('EdenEast/nightfox.nvim')
now(function()
  require('conf.plugins.nightfox').setup()
end)

add('nvim-lualine/lualine.nvim')
now(function()
  require('conf.plugins.lualine').setup()
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
add('neovim/nvim-lspconfig')
add('mrjones2014/smart-splits.nvim')
add('rafamadriz/friendly-snippets')

now(function()
  require('conf.plugins.treesitter').setup()
  require('conf.plugins.lspconfig').setup()
  require('conf.plugins.smart-splits').setup()
end)

later(function()
  require('mini.files').setup({
    windows = {
      preview = true,
      width_preview = 75,
    },
  })
  vim.keymap.set('n', '-', MiniFiles.open)

  require('mini.notify').setup()

  require('mini.completion').setup()

  local pick = require('mini.pick')
  local extra = require('mini.extra')
  pick.setup()
  extra.setup()
  vim.keymap.set('n', '<leader>ff', pick.builtin.files)
  vim.keymap.set('n', '<leader>fg', pick.builtin.grep_live)
  vim.keymap.set('n', '<leader>fe', extra.pickers.explorer)
  vim.keymap.set('n', '<leader>fh', extra.pickers.git_hunks)
  vim.keymap.set('n', '<leader>fl', extra.pickers.buf_lines)
  vim.keymap.set('n', '<leader>fd', extra.pickers.diagnostic)

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
end)

later(function()
  local map_multistep = require('mini.keymap').map_multistep

  map_multistep('i', '<Tab>',   { 'pmenu_next' })
  map_multistep('i', '<S-Tab>', { 'pmenu_prev' })
  map_multistep('i', '<CR>',    { 'pmenu_accept', 'minipairs_cr' })
  map_multistep('i', '<BS>',    { 'minipairs_bs' })
end)

add('MeanderingProgrammer/render-markdown.nvim')
later(function()
  require('render-markdown').setup({
    completions = { lsp = { enabled = true } },
  })
end)

add('folke/snacks.nvim')
now(function()
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
end)

add({ source = 'NickvanDyke/opencode.nvim',
  depends = {
    'folke/snacks.nvim',
  },
})
later(function()
  require('conf.plugins.opencode').setup()
end)

add('jake-stewart/auto-cmdheight.nvim')
later(function()
  require('auto-cmdheight').setup()
end)
