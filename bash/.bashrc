#
# ~/.bashrc
#

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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

# -- Prompt -- #
colour_host=$colour_cyan
colour_dir=$colour_green
colour_branch=$colour_yellow

parse_git_branch() {
    git_branch="$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* //')"
    test -n "$git_branch" && printf '%s(%s)%s' "$colour_branch$(tput bold)" "$git_branch" "$term_reset"
}

parse_dir() {
    dir=$(pwd)
    echo "${dir/#$HOME/'~'}"
}

# -- __vte_prompt_command to set directory -- #
if [[ $TERM == *-termite ]]; then
    vte_sh="/etc/profile.d/vte.sh"
    [[ -f "$vte_sh" ]] && [[ -r "$vte_sh" ]] && . "$vte_sh"
    unset vte_sh
fi

prompt() {
    [[ "$TERM" == *-termite ]] && __vte_prompt_command
    PS1="${colour_host}$(tput bold)\u@\h${term_reset} [${colour_dir}$(tput bold)$(parse_dir)${term_reset}] $(parse_git_branch)\n"
}

PROMPT_COMMAND="prompt"

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION

if [[ -d ~/.bashrc.d ]]; then
    for cfg in ~/.bashrc.d/?*.sh; do
        [ -x "$cfg" ] && source "$cfg"
    done
    unset cfg
fi
