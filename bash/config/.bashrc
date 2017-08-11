#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# -- Colour -- #
if [[ -x /usr/bin/tput ]] && tput setaf 1 >&/dev/null; then
    case $TERM in
        *-256color) 
            colour_green="$(tput setaf 10)"
            colour_cyan="$(tput setaf 14)"
            ;;
        *)
            colour_green="$(tput setaf 2)"
            colour_cyan="$(tput setaf 6)"
            ;;
    esac
    colour_reset="$(tput sgr0)"
fi

alias ls='ls --color=auto'

# -- Prompt -- #
colour_host=$colour_cyan
colour_dir=$colour_green

function prompt {
    PS1='$ '
    printf '%s%s@%s%s [%s%s%s]\n' "$colour_host" "$USER" "$HOSTNAME" "$colour_reset" "$colour_dir" "${PWD/#$HOME/'~'}" "$colour_reset"
}
PROMPT_COMMAND=prompt

# -- Extended completion -- #
source /usr/share/bash-completion/bash_completion

