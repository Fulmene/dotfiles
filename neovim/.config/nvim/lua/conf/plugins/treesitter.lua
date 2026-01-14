if TreeSitter then return end
TreeSitter = {}

function TreeSitter.setup()
  local treesitter = require('nvim-treesitter')
  treesitter.setup {
    -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
    install_dir = vim.fn.stdpath('data') .. '/site'
  }

  treesitter.install {
    'lua',
    'python',
    'typescript',
    'css',
    'json',
    'csv',
    'html',
    'gdscript',
    'godot_resource',
    'gdshader',
  }

  vim.opt.foldmethod = 'expr'
  vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  vim.opt.foldtext = ""
  vim.opt.foldlevel = 3
  vim.opt.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end

return TreeSitter
