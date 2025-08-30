if LuaLine then return end
LuaLine = {}

function LuaLine.setup()
    local winbar = {
        lualine_a = { 'filename' },
        lualine_b = { 'navic' },
    }

    local status = {
        lualine_c = {},
        lualine_y = { 'searchcount', 'progress' },
    }

    local bufferline = {
        lualine_a = { 'buffers' },
    }

    require('lualine').setup {
        winbar = winbar,
        inactive_winbar = winbar,
        sections = status,
        tabline = bufferline,
        options = {
            theme = 'nordfox',
            globalstatus = true,
        },
    }
end

return LuaLine
