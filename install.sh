# ~/dotfiles/install.sh
#!/bin/bash

# Requirements
# brew install neovim ripgrep fzf node corepack

# Configure Neovim
mkdir -p ~/.config
rm -rf ~/.config/nvim
ln -s ~/GitHub/dotfiles/nvim ~/.config/nvim

echo "Neovim... Done."
