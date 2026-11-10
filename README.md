# Install 
```shell
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply https://github.com/nicolascochin/dotfiles.git
```

# Paquets

Les listes sont dans `dot_config/packages/<famille>.txt` (`darwin`, `debian`, `fedora`), un paquet par ligne.
`~/.local/bin/install-packages` installe ceux qui manquent. Il détecte la distribution à l'exécution, ce qui
permet de partager le même `$HOME` entre l'hôte et ses distrobox.

Il est lancé par chezmoi quand le script ou une liste change, et par `distroboxctl` (bluepill) à la création
d'une box. Sur un hôte Silverblue, il ne fait rien : les paquets de l'hôte sont gérés par bluepill.
