Remove-Item -Path "$home/.config/yasb/config.yaml"
New-Item -ItemType SymbolicLink `
    -Path "$home/.config/yasb/config.yaml" `
    -Target "$home/.dotfiles/yasb/config.yaml"

Remove-Item -Path "$home/.config/yasb/styles.yaml"
New-Item -ItemType SymbolicLink `
    -Path "$home/.config/yasb/styles.css" `
    -Target "$home/.dotfiles/yasb/styles.css"
