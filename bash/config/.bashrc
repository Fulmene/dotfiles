#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# -- Colour -- #
alias ls='ls --color=auto'

# -- Prompt -- #
function prompt {
    PS1="\$ "
    printf '%s@%s %s\n' "$USER" "$HOSTNAME" "${PWD/#$HOME/'~'}"
}
PROMPT_COMMAND=prompt

# -- Extended completion -- #
source /usr/share/bash-completion/bash_completion

