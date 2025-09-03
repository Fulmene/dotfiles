if LspConfig then return end
LspConfig = {}

function LspConfig.setup()
    local servers = {
        'lua_ls',
        'pyrefly',
        'ruff',
        'ts_ls',
        'cssls',
        'jsonls',
        'html',
    }

    for _, ls in ipairs(servers) do
        vim.lsp.enable(ls)
    end

    vim.lsp.config('ruff', {
        init_options = {
            settings = {
                lineLength = 100,
                lint = {
                    enable = false,
                },
            }
        }
    })
end

return LspConfig
