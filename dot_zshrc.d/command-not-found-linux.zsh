# command-not-found dans les conteneurs Arch (distrobox).
# Debian/Ubuntu et l'hôte Fedora passent par le plugin oh-my-zsh (voir .zshrc).
# Pas de prise en charge des conteneurs Fedora : PackageKit-command-not-found
# a besoin du bus D-Bus système, que distrobox ne partage pas.

# Arch : hook fourni par pkgfile (base remplie par install-packages).
# Le fichier est présent dans une distrobox : distrobox-init retire les
# NoExtract de pacman.conf.
if [[ -r /usr/share/doc/pkgfile/command-not-found.zsh ]]; then
  source /usr/share/doc/pkgfile/command-not-found.zsh
fi
