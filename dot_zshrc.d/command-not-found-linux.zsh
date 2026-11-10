# command-not-found dans les conteneurs Arch et Fedora (distrobox, devcontainers).
# Debian/Ubuntu et l'hôte Fedora passent par le plugin oh-my-zsh (voir .zshrc).
# Ce fichier est chargé après les plugins oh-my-zsh : son handler l'emporte.

# Arch : hook fourni par pkgfile (base remplie par install-packages).
# Le fichier est présent dans une distrobox : distrobox-init retire les
# NoExtract de pacman.conf.
if [[ -r /usr/share/doc/pkgfile/command-not-found.zsh ]]; then
  source /usr/share/doc/pkgfile/command-not-found.zsh
fi

# Fedora en conteneur : PackageKit-command-not-found a besoin du bus D-Bus
# système, que distrobox ne partage pas. On demande à dnf quel paquet fournit
# /usr/bin/<commande> (Fedora 42+ a fusionné /usr/sbin dans /usr/bin), depuis
# le cache des métadonnées (-C) pour répondre vite. Ce cache est celui de root,
# rempli par distrobox-init et install-packages : d'où sudo -n.
if [[ -r /etc/fedora-release && ( -e /run/.containerenv || -e /.dockerenv ) ]] && (( $+commands[dnf] )); then
  command_not_found_handler() {
    local cmd=$1
    local -a query pkgs

    print -u2 "zsh: command not found: $cmd"

    query=(dnf -C -q repoquery --file "/usr/bin/$cmd" --qf $'%{name}\n')
    if (( EUID != 0 )); then
      (( $+commands[sudo] )) || return 127
      query=(sudo -n $query)
    fi

    # (f) : une ligne par paquet, (u) : sans doublons ; les lignes vides
    # (dnf4 ajoute son propre saut de ligne) disparaissent hors guillemets.
    pkgs=(${(fu)"$($query 2>/dev/null)"})

    if (( $#pkgs )); then
      print -u2 "Fourni par : ${(j:, :)pkgs}"
      print -u2 "  sudo dnf install ${pkgs[1]}"
    fi
    return 127
  }
fi
