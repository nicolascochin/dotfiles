if cmd_exists bat
then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
  export FORGIT_PAGER=bat

  function help() {
    "$@" --help 2>&1 | bat --plain --language=help
  }
#  unalias help

  # Le cache des thèmes est construit par run_onchange_after_bat-cache.sh
  export BAT_THEME="Catppuccin Mocha"
fi
