#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# -- Colour -- #
if which tput >&/dev/null; then
    if tput setaf 9 >&/dev/null; then
        colour_red="$(tput setaf 9)"
        colour_green="$(tput setaf 10)"
        colour_cyan="$(tput setaf 14)"
    elif tput setaf 1 >&/dev/null; then
        colour_red="$(tput setaf 1)"
        colour_green="$(tput setaf 2)"
        colour_cyan="$(tput setaf 6)"
    fi
    term_reset="$(tput sgr0)"
fi

# -- Extended completion -- #
source /usr/share/bash-completion/bash_completion

# -- Prompt -- #
colour_host=$colour_cyan
colour_dir=$colour_green
function prompt {
    PS1="\$\[$term_reset\] "
    printf '%s%s@%s%s [%s%s%s]\n%s' "${colour_host}$(tput bold)" "$USER" "$HOSTNAME" "$term_reset" "${colour_dir}$(tput bold)" "${PWD/#$HOME/'~'}" "$term_reset" "$(tput bold)"
}
PROMPT_COMMAND=prompt

if [[ -d ~/.bashrc.d ]]; then
    for cfg in ~/.bashrc.d/?*.sh; do
        [ -x "$cfg" ] && source "$cfg"
    done
    unset cfg
fi

