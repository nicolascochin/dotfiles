if command_exists bat
then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
  export FORGIT_PAGER=bat

  function help() {
    "$@" --help 2>&1 | bat --plain --language=help
  }
#  unalias help

  export BAT_THEME=Dracula
fi
