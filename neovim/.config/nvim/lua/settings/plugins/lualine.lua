local lualine = require('lualine')
local navic = require('nvim-navic')

local winbar = {
    lualine_a = { 'filename' },
    lualine_b = {
        { navic.get_location, cond = navic.is_available },
    },
}

local status = {
    lualine_c = {},
    lualine_y = { 'searchcount', 'progress' },
}

local bufferline = {
    lualine_a = { 'buffers' },
}

lualine.setup {
    winbar = winbar,
    inactive_winbar = winbar,
    sections = status,
    tabline = bufferline,
    options = {
        theme = 'nordfox',
        globalstatus = true,
    },
}
