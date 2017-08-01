" Platform-specific path
if has('unix')
  if !empty($XDG_CONFIG_HOME)
    let configpath = expand($XDG_CONFIG_HOME . '/nvim')
  else
    let configpath = expand('$HOME/.config/nvim')
  endif
elseif has('win32')
  let configpath = expand('$HOME/AppData/Local/nvim')
endif

let settingspath = expand(configpath . '/settings')
let pluginpath = expand(configpath . '/dein')

exec "source " . pluginpath . "/dein.vim"

exec "source " . settingspath . "/general.vim"
exec "source " . settingspath . "/keys.vim"
exec "source " . settingspath . "/local.vim"

exec "source " . pluginpath . "/setup.vim"

