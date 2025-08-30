if RemoteNvim then return end
RemoteNvim = {}

function RemoteNvim.setup()
    require('remote-nvim').setup({
        devpod = {
            dotfiles = {
                path = 'https://github.com/Fulmene/dotfiles.git',
                install_script = 'install-container.sh'
            },
        },
        remote = {
            copy_dirs = {
                config = {
                    base = '~/dotfiles/neovim/',
                },
            },
        },
    })
end

return RemoteNvim
