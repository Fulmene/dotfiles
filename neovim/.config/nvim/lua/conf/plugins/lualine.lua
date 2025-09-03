if LuaLine then return end
LuaLine = {}

function LuaLine.setup()
    require('lualine').setup {
        tabline = {
            lualine_a = { 'buffers' },
        },
        options = {
            component_separators = { left = '|', right = '|' },
            section_separators = { left = '', right = '' },
            globalstatus = true,
        },
    }
end

return LuaLine
