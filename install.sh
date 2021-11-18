#!/usr/bin/env bash

# Install ZSH
sudo apt-get install -y vim zsh nano shopt
sudo chsh -s /bin/zsh $USER

# Install and configure Oh My ZSH (if it is not already installed)
if [ -d "/home/coder/.oh-my-zsh" ] 
then
    echo "oh-my-zsh is already installed" 
else
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    # Append zshrc stuff to end of file
    touch ~/.zshrc # not sure if this will always exist at this point :/
    cat .zshrc >> ~/.zshrc
fi

DOTFILES_CLONE_PATH=$HOME/dotfiles
for dotfile in "$DOTFILES_CLONE_PATH/".*; do
  # Skip `..` and '.'
  [[ $dotfile =~ \.{1,2}$ ]] && continue
  # Skip Git related
  [[ $dotfile =~ \.git$ ]] && continue
  [[ $dotfile =~ \.gitignore$ ]] && continue
  [[ $dotfile =~ \.gitattributes$ ]] && continue

  echo "Symlinking $dotfile"
  ln -sf "$dotfile" "$HOME"
done
