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
    colour_bblack="$(tput setaf 8)"
    colour_bred="$(tput setaf 9)"
    colour_bgreen="$(tput setaf 10)"
    colour_byellow="$(tput setaf 11)"
    colour_bblue="$(tput setaf 12)"
    colour_bmagenta="$(tput setaf 13)"
    colour_bcyan="$(tput setaf 14)"
    colour_bwhite="$(tput setaf 15)"

    term_reset="$(tput sgr0)"
fi

# -- Extended completion -- #
source /usr/share/bash-completion/bash_completion

# -- Prompt -- #
case $TERM in
    *color)
        ;&
    *-termite)
        colour_host=$colour_byellow
        colour_dir=$colour_bblue
        colour_branch=$colour_byellow
        ;;
    *)
        colour_host=$colour_cyan
        colour_dir=$colour_green
        colour_branch=$colour_yellow
        ;;
esac

parse_git_branch() {
    git_branch="$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* //')"
    test -n "$git_branch" && printf '(%s%s%s)' "$colour_branch$(tput bold)" "$git_branch" "$term_reset"
}

# -- __vte_prompt_command to set directory -- #
if [[ $TERM == *-termite ]]; then
    vte_sh="/etc/profile.d/vte.sh"
    [[ -f "$vte_sh" ]] && [[ -r "$vte_sh" ]] && . "$vte_sh"
    unset vte_sh
fi

prompt() {
    [[ "$TERM" == *-termite ]] && __vte_prompt_command
    printf '%s%s@%s%s [%s%s%s] %s\n' "${colour_host}$(tput bold)" "$USER" "$HOSTNAME" "$term_reset" "${colour_dir}$(tput bold)" "${PWD/#$HOME/'~'}" "$term_reset" "$(parse_git_branch)"
}

PROMPT_COMMAND="prompt"
PS1="\[$(tput bold)\]\$\[$term_reset\] "

if [[ -d ~/.bashrc.d ]]; then
    for cfg in ~/.bashrc.d/?*.sh; do
        [ -x "$cfg" ] && source "$cfg"
    done
    unset cfg
fi

