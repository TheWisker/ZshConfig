sudo pacman -S zoxide zsh-syntax-highlighting zsh-autosuggestions
sleep
sudo cat > /etc/pacman.d/hooks/zsh.hook << EOF
[Trigger]
Operation = Install
Operation = Upgrade
Operation = Remove
Type = Path
Target = usr/bin/*
[Action]
Depends = zsh
When = PostTransaction
Exec = /usr/bin/install -Dm644 /dev/null /var/cache/zsh/pacman
EOF