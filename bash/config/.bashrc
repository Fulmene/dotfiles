#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# -- Colour -- #
if which tput &> /dev/null; then
    case $TERM in
        *color)
            ;&
        *-termite)
            colour_black="$(tput setaf 8)"
            colour_red="$(tput setaf 9)"
            colour_green="$(tput setaf 10)"
            colour_yellow="$(tput setaf 11)"
            colour_blue="$(tput setaf 12)"
            colour_magenta="$(tput setaf 13)"
            colour_cyan="$(tput setaf 14)"
            colour_white="$(tput setaf 15)"
            ;;
        *)
            colour_black="$(tput setaf 0)"
            colour_red="$(tput setaf 1)"
            colour_green="$(tput setaf 2)"
            colour_yellow="$(tput setaf 3)"
            colour_blue="$(tput setaf 4)"
            colour_magenta="$(tput setaf 5)"
            colour_cyan="$(tput setaf 6)"
            colour_white="$(tput setaf 7)"
            ;;
    esac
    term_reset="$(tput sgr0)"
fi

# -- Extended completion -- #
source /usr/share/bash-completion/bash_completion

# -- Prompt -- #
colour_host=$colour_cyan
colour_dir=$colour_green
colour_branch=$colour_yellow
function parse_git_branch {
    git_branch="$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* //')"
    test -n "$git_branch" && printf '(%s%s%s)' "$colour_branch" "$git_branch" "$term_reset"
}
function prompt {
    PS1="\$\[$term_reset\] "
    printf '%s%s@%s%s [%s%s%s] %s\n%s' "${colour_host}$(tput bold)" "$USER" "$HOSTNAME" "$term_reset" "${colour_dir}$(tput bold)" "${PWD/#$HOME/'~'}" "$term_reset" "$(parse_git_branch)" "$(tput bold)"
}
PROMPT_COMMAND=prompt

if [[ -d ~/.bashrc.d ]]; then
    for cfg in ~/.bashrc.d/?*.sh; do
        [ -x "$cfg" ] && source "$cfg"
    done
    unset cfg
fi

