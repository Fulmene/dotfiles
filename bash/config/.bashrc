#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# -- Colour -- #
if which tput &> /dev/null; then
    colour_black="$(tput setaf 0)"
    colour_red="$(tput setaf 1)"
    colour_green="$(tput setaf 2)"
    colour_yellow="$(tput setaf 3)"
    colour_blue="$(tput setaf 4)"
    colour_magenta="$(tput setaf 5)"
    colour_cyan="$(tput setaf 6)"
    colour_white="$(tput setaf 7)"
    colour_lblack="$(tput setaf 8)"
    colour_lred="$(tput setaf 9)"
    colour_lgreen="$(tput setaf 10)"
    colour_lyellow="$(tput setaf 11)"
    colour_lblue="$(tput setaf 12)"
    colour_lmagenta="$(tput setaf 13)"
    colour_lcyan="$(tput setaf 14)"
    colour_lwhite="$(tput setaf 15)"

    term_reset="$(tput sgr0)"
fi

# -- Extended completion -- #
source /usr/share/bash-completion/bash_completion

# -- Prompt -- #
case $TERM in
    *color)
        ;&
    *-termite)
        colour_host=$colour_yellow
        colour_dir=$colour_lwhite
        colour_branch=$colour_lyellow
        ;;
    *)
        colour_host=$colour_cyan
        colour_dir=$colour_green
        colour_branch=$colour_yellow
        ;;
esac
function parse_git_branch {
    git_branch="$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* //')"
    test -n "$git_branch" && printf '(%s%s%s)' "$colour_branch" "$git_branch" "$term_reset"
}
function prompt {
    PS1="\[$(tput bold)\]\$\[$term_reset\] "
    printf '%s%s@%s%s [%s%s%s] %s\n' "${colour_host}$(tput bold)" "$USER" "$HOSTNAME" "$term_reset" "${colour_dir}$(tput bold)" "${PWD/#$HOME/'~'}" "$term_reset" "$(parse_git_branch)"
}
PROMPT_COMMAND=prompt

if [[ -d ~/.bashrc.d ]]; then
    for cfg in ~/.bashrc.d/?*.sh; do
        [ -x "$cfg" ] && source "$cfg"
    done
    unset cfg
fi

