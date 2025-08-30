if LspConfig then return end
LspConfig = {}

function LspConfig.setup()
    local servers = {
        'lua_ls',
        'basedpyright',
        'ts_ls',
        'cssls',
        'jsonls',
        'html',
    }

    for _, ls in ipairs(servers) do
        vim.lsp.enable(ls)
    end
end

return LspConfig
