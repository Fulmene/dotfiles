#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# -- Colour -- #
if which tput &> /dev/null; then
    colour_red="$(tput setaf 1)"
    colour_green="$(tput setaf 2)"
    colour_yellow="$(tput setaf 3)"
    colour_cyan="$(tput setaf 6)"
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

