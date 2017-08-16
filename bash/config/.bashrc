#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# -- Colour -- #
if [[ -x /usr/bin/tput ]] && tput setaf 1 >&/dev/null; then
    case $TERM in
        *-256color) 
            colour_red="$(tput setaf 9)"
            colour_green="$(tput setaf 10)"
            colour_cyan="$(tput setaf 14)"
            ;;
        *)
            colour_red="$(tput setaf 1)"
            colour_green="$(tput setaf 2)"
            colour_cyan="$(tput setaf 6)"
            ;;
    esac
fi
term_reset="$(tput sgr0)"

# -- Coloured output -- #
alias ls='ls --color=auto'
alias diff='diff --color=auto'
alias grep='grep --color=auto'

export LESS=-R
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# -- Prompt -- #
colour_host=$colour_cyan
colour_dir=$colour_green

function prompt {
    PS1="\$\[$term_reset\] "
    printf '%s%s@%s%s [%s%s%s]\n%s' "${colour_host}$(tput bold)" "$USER" "$HOSTNAME" "$term_reset" "${colour_dir}$(tput bold)" "${PWD/#$HOME/'~'}" "$term_reset" "$(tput bold)"
}
PROMPT_COMMAND=prompt

# -- Extended completion -- #
source /usr/share/bash-completion/bash_completion

# -- Wine font -- #
alias wine='env FREETYPE_PROPERTIES="truetype:interpreter-version=35" wine'
alias winecfg='env FREETYPE_PROPERTIES="truetype:interpreter-version=35" winecfg'
alias winetricks='env FREETYPE_PROPERTIES="truetype:interpreter-version=35" winetricks'

# -- PyWal colourscheme -- #
(wal -rt &)

